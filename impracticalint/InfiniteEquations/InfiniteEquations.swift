//
//  InfiniteEquations.swift
//  impracticalint
//
//  Created by David M. Galvan on 2/16/23.
//

import SwiftUI


//struct InfiniteEquations: View {
//    @State var timeRemaining = 10
//    @State var timeConfig = 10
//    let countdown = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @AppStorage("infCorrectScore") private var infCorrectScore = 0
//    @AppStorage("infIncorrectScore") private var infIncorrectScore = 0
//    @State var ratioScore: Double = 0.0
//    @State var sliderValue: Float = 2.0
//    @State var attempts: Int = 0
//    @State var equations = false
//    @State var answer = ""
//    @State var converted = ""
//    @State var timer = -1
//    @State var text = "Begin"
//    @Environment(\.presentationMode) var presentationMode
//    @State var currentInfo = equationInfo(terms: [Int](), answer: 0, displayText: "")
//    var body: some View {
//
//        VStack {
//
//            Image(systemName: "infinity.circle.fill")
//                .imageScale(.large)
//                .foregroundColor(.red)
//            Text("Infinity!")
//            Divider()
//                .frame(width: 200)
//
//            if !equations{
//                Text("Term Count:")
//                    .font(.headline)
//                Text("\(Int(sliderValue))").font(.title2).fontWeight(.thin)
//                Slider(value: $sliderValue, in: 2...5) {
//                } minimumValueLabel: {
//                    Text("2").font(.callout).fontWeight(.thin)
//                } maximumValueLabel: {
//                    Text("5").font(.callout).fontWeight(.thin)
//                }
//                .frame(width: 125, height: 5)
//
//                    Text("C/I Ratio:")
//                    Text("\(converted)").font(.title2).fontWeight(.thin)
//                    .onAppear(perform: {
//                         converted = String(format: "%.1f", (Double(infCorrectScore) / Double(infIncorrectScore)))
//                    })
//            }
//            if equations {
//                Text(String(timeRemaining))
//                    .font(.largeTitle)
//                    .onReceive(countdown){ time in
//                        if timeRemaining > 0 {
//
//                            timeRemaining -= 1
//                        }else{
//                            infIncorrectScore += 1
//                            timeRemaining = timeConfig
//                            print("\(infCorrectScore) / \(infIncorrectScore)")
//                            ratioScore = Double(infCorrectScore) / Double(infIncorrectScore)
//                            currentInfo = generateEquation(termCount: Int(sliderValue))
//
//
//                        }
//                    }
//                Text(currentInfo.displayText)
//                TextField("Answer", text: $answer)
//                    .textFieldStyle(.roundedBorder)
//                    .frame(width: 125)
//                    .modifier(jiggleEffect(animatableData: CGFloat(attempts)))
//                    .multilineTextAlignment(.center)
//                Button("Submit"){
//                    if answer == String(currentInfo.answer){
//                        infCorrectScore += 1
//                        currentInfo = generateEquation(termCount: Int(sliderValue))
//                        timeRemaining = timeConfig
//                        answer = ""
//                    } else {
//                        infIncorrectScore += 1
//                        withAnimation(.default){
//                            attempts += 1
//                            answer = ""
//                        }
//                    }
//                }
//                .foregroundColor(.white)
//                .buttonStyle(.borderedProminent)
//                .tint(.red)
//            }
//            Button("\(text)") {
//                if equations{
//                    equations = false
//                    text = "Begin"
//                } else {
//                    equations = true
//                    text = "End"
//                    currentInfo = generateEquation(termCount: Int(sliderValue))
//                    timeRemaining = 10
//                }
//            }
//            .foregroundColor(.white)
//            .buttonStyle(.borderedProminent)
//            .tint(.red)
//            if !equations{
//                Button("Back"){
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .accentColor(.red)
//
//            }
//
//
//        }
//    }
//
//}
//
//
//
//struct InfiniteEquations_Previews: PreviewProvider {
//    static var previews: some View {
//        InfiniteEquations()
//    }
import AVFoundation
import PopupView


struct InfiniteEquations: View {
    
    @State var shouldAnimateCheckmark = false
    @State var timeRemaining = 10
    @State var timeConfig = 10
    @State var ratioScore: Double = 0.0
    @State var difficultyValue: Int = 2
    @State var attempts: Int = 0
    @State var equations = false
    @State var answer = ""
    @State var converted = ""
    @State var timer = -1
    @State var text = "Begin"
    @State var currentInfo = equationInfo(terms: [Int](), answer: 0, displayText:"")
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("infCorrectScore") private var infCorrectScore = 0
    @AppStorage("infIncorrectScore") private var infIncorrectScore = 0
    
    let countdown = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let buttonBackground = Color("buttonBackground")
    let endSoundEffect: SystemSoundID = 1112
    let startSoundEffect: SystemSoundID = 1110


    private func startGame(){
        answer = ""
        AudioServicesPlaySystemSound(startSoundEffect)
        equations = true
        currentInfo = generateEquation(termCount: difficultyValue)
        timeRemaining = 5
    }
    
    private func endGame(animated: Bool){
        answer = ""
        AudioServicesPlaySystemSound(endSoundEffect)
        if (animated){
            withAnimation(.none) {
                equations = false
            }
        }else{
            equations = false
        }
        
    }
    
    var body: some View {
        ZStack{
            Image("wateriscool")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                if !equations{
                    InfiniteMenuView(
                        difficultyValue: $difficultyValue,
                        infCorrectScore: $infCorrectScore,
                        infIncorrectScore: $infIncorrectScore,
                        startGame: {
                            self.startGame()
                        })
                }else{
                    InfiniteGameView(
                        shouldAnimateCheckmark: $shouldAnimateCheckmark,
                        timeRemaining: $timeRemaining,
                        answer: $answer,
                        attempts: $attempts,
                        difficultyValue: $difficultyValue,
                        currentInfo: $currentInfo,
                        infCorrectScore: $infCorrectScore,
                        infIncorrectScore: $infIncorrectScore,
                        endGame: {
                            self.endGame(animated: true)
                        })
                    Spacer()
                        .frame(maxHeight: 30)
                    Keypad(answer: $answer,
                           attempts: $attempts,
                           endGame: {
                        self.endGame(animated: true)
                    })
                }
            }
        }
//        .popup(isPresented: $popupPresented) {
//            HighScorePopup(popupPresented: $popupPresented, leaderboardNavigate: $leaderboardNavigate)
//        } customize: {
//            $0
//               // .autohideIn(2)
//                .type(.toast)
//                .position(.bottom)
//                .animation(.spring())
//                .closeOnTapOutside(true)
//                .backgroundColor(.black.opacity(0.5))
//        }
//        .navigate(to: ScoreboardView(), when: $leaderboardNavigate)

    }
}




#Preview {
        HomeScreen()
    }

