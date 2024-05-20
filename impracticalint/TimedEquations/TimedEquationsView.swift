//
//  TimedEquations.swift
//  impracticalint
//
//  Created by David M. Galvan on 2/16/23.
//

import SwiftUI
import AVFoundation
import PopupView



struct TimedEquations: View {
    @State var shouldAnimateCheckmark = false
    @State var timeRemaining = 60
    @State var sessionScore = 0
    @State var sliderValue: Float = 2.0
    @State var attempts: Int = 0
    @State var leaderboardNavigate = false
    @State var equations = false
    @State var answer = ""
    @State var timer = -1
    @State var currentInfo = equationInfo(terms: [Int](), answer: 0, displayText: "")
    @State var popupPresented = false
    @AppStorage("easyHighScore") private var easyHighScore = -1
    @AppStorage("normalHighScore") private var normalHighScore = -1
    @AppStorage("hardHighScore") private var hardHighScore = -1

    @Environment(\.presentationMode) var presentationMode
    let buttonBackground = Color("buttonBackground")
    let endSoundEffect: SystemSoundID = 1112
    let startSoundEffect: SystemSoundID = 1110

    private func startGame(){
        answer = ""
        AudioServicesPlaySystemSound(startSoundEffect)
        equations = true
        sessionScore = 0
        currentInfo = generateEquation(termCount: Int(sliderValue))
        timeRemaining = 60
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
        
        switch sliderValue{
        case 2.0:
            if (sessionScore > easyHighScore && sessionScore != 0){
                easyHighScore = sessionScore
                sessionScore = 0
                popupPresented = true
            }
        case 3.0:
            if (sessionScore > normalHighScore && sessionScore != 0){
                normalHighScore = sessionScore
                sessionScore = 0
                popupPresented = true
            }
        case 4.0:
            if (sessionScore > hardHighScore && sessionScore != 0){
                hardHighScore = sessionScore
                sessionScore = 0
                popupPresented = true
            }
        default: return
        }

        
    }
    
    var body: some View {
        ZStack{
            Image("wateriscool") // 1
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                if !equations{
                    TimedMenuView(
                        sliderValue: $sliderValue,
                        timedHighScore: $easyHighScore,
                        startGame: {
                            self.startGame()
                        })
                }else{
                    TimedGameView(
                        shouldAnimateCheckmark: $shouldAnimateCheckmark,
                        timeRemaining: $timeRemaining,
                        timedHighScore: $easyHighScore,
                        answer: $answer,
                        attempts: $attempts,
                        sessionScore: $sessionScore,
                        sliderValue: $sliderValue,
                        currentInfo: $currentInfo,
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
        .popup(isPresented: $popupPresented) {
            HighScorePopup(popupPresented: $popupPresented, leaderboardNavigate: $leaderboardNavigate)
        } customize: {
            $0
               // .autohideIn(2)
                .type(.toast)
                .position(.bottom)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        }
        .navigate(to: ScoreboardView(), when: $leaderboardNavigate)

    }
}




#Preview {
        HomeScreen()
    }


