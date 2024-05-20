//
//  TimedGame.swift
//  impracticalint
//
//  Created by David on 5/11/24.
//

import SwiftUI
import AVFoundation


struct TimedGameView: View{
    @Binding var shouldAnimateCheckmark: Bool
    @Binding var timeRemaining: Int
    @Binding var timedHighScore: Int
    @Binding var answer: String
    @Binding var attempts: Int
    @Binding var sessionScore: Int
    @Binding var sliderValue: Float
    @Binding var currentInfo: equationInfo
    private let countdown = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var endGame: () -> Void
    let buttonBackground = Color("buttonBackground")
    @Environment(\.presentationMode) var presentationMode
    let systemSoundID: SystemSoundID = 1407
    
    var body: some View{
        ZStack{
            
            VStack{
                Image(systemName: "clock.fill")
                    .imageScale(.large)
                    .foregroundColor(buttonBackground)
                Text(String(timeRemaining))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .onReceive(countdown) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            self.endGame()
                        }
                    }
                
                AnimatedCheckmarkView(isAnimating: $shouldAnimateCheckmark)
                Text(currentInfo.displayText)
                TextField("Answer", text: $answer)
                    .frame(width: 180    )
                    .font(.headline)
                    .fontWeight(.heavy)
                    .modifier(jiggleEffect(animatableData: CGFloat(attempts)))
                    .multilineTextAlignment(.center)
                    .buttonStyle(.borderedProminent)
                    .tint(buttonBackground)
                    .onChange(of: answer) { newValue in
                        if let userAnswer = Int(newValue),
                           userAnswer == currentInfo.answer {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                AudioServicesPlaySystemSound(systemSoundID)
                                shouldAnimateCheckmark = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    shouldAnimateCheckmark = false
                                }
                                sessionScore += 1
                                currentInfo = generateEquation(termCount: Int(sliderValue))
                                answer = ""
                            }
                        }
                    }
                Spacer()
                    .frame(maxHeight: 20)
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .transition(.slideInFromBottom)
            .animation(.spring())
            }
    }
}
