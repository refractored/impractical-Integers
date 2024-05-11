//
//  TimedMenu.swift
//  impracticalint
//
//  Created by David on 5/11/24.
//

import SwiftUI

struct MenuScreen: View{
    @Binding var sliderValue: Float
    @Binding var timedHighScore: Int
    @AppStorage("easyHighScore") private var easyHighScore = -1
    @AppStorage("normalHighScore") private var normalHighScore = -1
    @AppStorage("hardHighScore") private var hardHighScore = -1

    var startGame: () -> Void
    let buttonBackground = Color("buttonBackground")
    @Environment(\.presentationMode) var presentationMode
    let buttonForeground = Color("buttonForeground")

    var body: some View{
        VStack{
            Image(systemName: "clock.fill")
                .imageScale(.large)
                .foregroundColor(buttonBackground)
            Text("Timed")
                .fontWeight(.heavy)
                .font(.title3)
            Spacer()
                .frame(maxHeight: 30)
            VStack {
                HStack{
                    if easyHighScore != -1{
                        VStack{
                            Text("Easy")
                                .font(.title3)
                            Text("Top Score:")
                                .font(.title3)
                            Text("\(easyHighScore)").font(.title2).fontWeight(.thin)
                                .onAppear(perform: {
                                    print(normalHighScore)
                                })
                        }
                    }
                    if normalHighScore != -1{
                        VStack{
                            Text("Normal")
                                .font(.title3)

                            Text("Top Score:")
                                .font(.title3)
                            Text("\(normalHighScore)").font(.title2).fontWeight(.thin)
                        }
                    }
                    if hardHighScore != -1{
                        VStack{
                            Text("Hard")
                                .font(.title3)

                            Text("Top Score:")
                                .font(.title3)
                            Text("\(hardHighScore)").font(.title2).fontWeight(.thin)
                        }
                    }
                }
                Spacer()
                    .frame(maxHeight: 30)
                HStack{
                    Button(action:{
                        sliderValue = 2.0
                        
                    }) {
                        HStack {
                            Text("Easy")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(sliderValue == 2 ? Color("difficultySelector") : sliderValue != 2 ? Color("buttonBackground") : Color("buttonBackground"))
                    Button(action:{
                        sliderValue = 3.0
                    }) {
                        HStack {
                            Text("Normal")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                        
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(sliderValue == 3 ? Color("difficultySelector") : sliderValue != 3 ? Color("buttonBackground") : Color("buttonBackground"))
                    Button(action:{
                        sliderValue = 4.0
                    }) {
                        HStack {
                            Text("Hard")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                        
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(sliderValue == 4 ? Color("difficultySelector") : Color("buttonBackground"))
                }
                
            }
            Spacer()
                .frame(maxHeight: 30)
            Button(action:{
                self.startGame()
            }) {
                HStack {
                    Image(systemName: "play.circle")
                        .font(.title3)
                    Text("Start")
                        .font(.title3)
                }
                .frame(maxWidth: 320, maxHeight: 30)
                
            }
            .foregroundColor(buttonForeground)
            .buttonStyle(.borderedProminent)
            .tint(buttonBackground)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .tint(buttonBackground)
            Button(action:{
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "gobackward")
                        .font(.title3)
                    Text("Back")
                        .font(.title3)
                }
                .frame(maxWidth: 320, maxHeight: 30)
                
            }
            .foregroundColor(buttonForeground)
            .buttonStyle(.borderedProminent)
            .tint(buttonBackground)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .tint(buttonBackground)
        }
        .padding()
        .background(
                            .ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: 25, style: .continuous)
                        )
    }
}
