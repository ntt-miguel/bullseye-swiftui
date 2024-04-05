import SwiftUI

struct BackgroundView: View {
  @Binding var game: Game
  
  var body: some View {
    VStack {
      TopView(game: $game)
      Spacer()
      BottomView(game: $game)
    }
    .padding()
    .background(
      RingsView()
    )
  }
}

struct TopView: View {
  @Binding var game: Game
  @State private var leaderboardIsShowing = false
  
  var body: some View {
    HStack{
      Button(action: {
        game.restart()
      }, label: {
        RoundedImageViewStroked(systemName: "arrow.counterclockwise")
      })
      Spacer()
      Button(action: {
        leaderboardIsShowing = true
      }, label: {
        RoundedImageViewFilled(systemName: "list.dash")
      })
      .sheet(isPresented: $leaderboardIsShowing) {
        LeaderboardView(leaderboardIsShowing: $leaderboardIsShowing, game: $game)
      }
    }
  }
}

struct BottomView: View {
  @Binding var game: Game
  
  var body: some View {
    HStack{
      NumberView(title: "Score", text: String(game.score))
      Spacer()
      NumberView(title: "Round", text: String(game.round))
    }
  }
}

struct NumberView: View {
  var title: String
  var text: String
  
  var body: some View {
    VStack {
      LabelText(text: title)
      RoundedRectTextView(text: text)
    }
  }
}

struct RingsView: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
      ForEach(1..<6) { ring in
        let size = CGFloat(ring * 100)
        let opacity = colorScheme == .dark ? 0.1 : 0.3
        
        Circle()
          .stroke(lineWidth: 20)
          .fill(
            RadialGradient(colors: [Color("RingsColor").opacity(opacity * 0.8), Color("RingsColor").opacity(0)], center: .center, startRadius: 100, endRadius: 300)
          )
          .frame(width: size, height: size)
      }
    }
  }
}

#Preview {
  BackgroundView(game: .constant(Game()))
}
