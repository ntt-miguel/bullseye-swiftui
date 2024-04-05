import SwiftUI

struct PointsView: View {
  @Binding var alertIsVisible: Bool
  @Binding var sliderValue: Double
  @Binding var game: Game
  
  var body: some View {
    let roundedValue = Int(sliderValue.rounded())
    let points = game.points(sliderValue: roundedValue)
    
    VStack(spacing: 10) {
      InstructionText(text: "Your guess was")
      BigNumberText(text: String(roundedValue))
      BodyText(text: "You scored \(points) points \n 🏆🏆🏆")
      Button(action: {
        withAnimation {
          alertIsVisible = false
        }
        game.startNewRound(points: points)
      }, label: {
        ButtonText(text: "Start New Round")
      })
    }
      .padding()
      .frame(maxWidth: 300)
      .background(Color("BackgroundColor"))
      .cornerRadius(Constants.General.roundedRectCornerRadius)
      .shadow(radius: 10, x: 5, y: 5)
  }
}

#Preview {
//  static private var alertIsVisible = Binding.constant(false)
//  static private var sliderValue = Binding.constant(50.0)
//  static private var game = Binding.constant(Game())
  PointsView(alertIsVisible: Binding.constant(false), sliderValue: Binding.constant(50.0), game: Binding.constant(Game()))
}
