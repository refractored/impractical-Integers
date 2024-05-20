//
//  InfiniteMenuView.swift
//  impracticalint
//
//  Created by David on 5/20/24.
//

import Foundation
import SwiftUI

struct InfiniteMenuView: View{
    @Binding var difficultyValue: Int
    @Binding var infCorrectScore: Int
    @Binding var infIncorrectScore: Int

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
//                    if infCorrectScore != -1{
//                        VStack{
//                            Text("Correct")
//                                .font(.title3)
//                            Text("Top Score:")
//                                .font(.title3)
//                            Text("\(easyHighScore)").font(.title2).fontWeight(.thin)
//                                .onAppear(perform: {
//                                    print(normalHighScore)
//                                })
//                        }
//                    }
                }
                Spacer()
                    .frame(maxHeight: 30)
                HStack{
                    Button(action:{
                        difficultyValue = 2
                    }) {
                        HStack {
                            Text("Easy")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(difficultyValue == 2 ? Color("difficultySelector") : difficultyValue != 2 ? Color("buttonBackground") : Color("buttonBackground"))
                    
                    Button(action:{
                        difficultyValue = 3
                    }) {
                        HStack {
                            Text("Normal")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                        
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(difficultyValue == 3 ? Color("difficultySelector") : difficultyValue != 3 ? Color("buttonBackground") : Color("buttonBackground"))
                    
                    Button(action:{
                        difficultyValue = 4
                    }) {
                        HStack {
                            Text("Hard")
                                .font(.title3)
                        }
                        .frame(maxWidth: 80, maxHeight: 30)
                        
                    }
                    .foregroundColor(buttonForeground)
                    .buttonStyle(.borderedProminent)
                    .tint(difficultyValue == 4 ? Color("difficultySelector") : Color("buttonBackground"))
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
