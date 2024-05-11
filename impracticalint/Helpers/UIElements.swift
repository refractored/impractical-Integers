//
//  UIElements.swift
//  impracticalint
//
//  Created by David G on 8/11/23.
//

import SwiftUI
import AVFoundation

struct AnimatedCheckmarkView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(.green)
            .font(.system(size: 60))
            .opacity(isAnimating ? 1.0 : 0.0)
            .scaleEffect(isAnimating ? 1.0 : 0.2)
            .animation(
                isAnimating ?
                    Animation.spring(response: 0.5, dampingFraction: 0.5)
                    : .default
            )
            .onAppear {
                if isAnimating {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isAnimating = false
                    }
                }
            }
    }
}

struct Keypad: View {
    @Binding var answer: String
    @Binding var attempts: Int
    let systemSoundID: SystemSoundID = 1306

    var endGame: () -> Void

    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(1...3, id: \.self) { number in
                        Button(action: {
                            AudioServicesPlaySystemSound(systemSoundID)
                            answer += "\(number + row * 3)"
                        }) {
                            Text("\(number + row * 3)")
                        }
                        .buttonStyle(KeyButton())
                    }
                }
            }
            HStack {
                Button(action: {
                    AudioServicesPlaySystemSound(systemSoundID)
                    answer += "-"
                }) {
                    Text("-")
                }
                .buttonStyle(KeyButton())
                Button(action: {
                    AudioServicesPlaySystemSound(systemSoundID)
                    answer += "0"
                }) {
                    Text("0")
                }
                .buttonStyle(KeyButton())
                Button(action: {
                    AudioServicesPlaySystemSound(systemSoundID)
                    answer = ""
                    withAnimation(.default) {
                        attempts += 1
                        answer = ""
                    }
                }) {
                    Text("C")
                }
                .buttonStyle(KeyButton())
            }
            Button("End") {
                endGame()
            }
            .frame(width: 245, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .foregroundColor(Color("buttonBackground"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("foregroundTwo"), lineWidth: 4)
                    )
            )
            .foregroundColor(Color("foregroundTwo"))
            .font(.title)
            .fontWeight(.heavy)
            .animation(.spring())
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
        .transition(.slideInFromBottom)
    }
}

struct LabelledDivider: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct HighScorePopup: View {
    @Binding var popupPresented: Bool
    @Binding var leaderboardNavigate: Bool
    var body: some View {
        ZStack{
            Spacer()
                .frame(height: 325)
                .background(Color("buttonBackground"))
                .cornerRadius(30.0)
            VStack{
                Text("Congratulations!")
                    .fontWeight(.heavy)
                    .font(.title)
                Text("🎉")
                    .font(.system(size: 75))
                Text("You've beat your previous high score!")
                    .fontWeight(.heavy)
                    .font(.system(size: 15))
                Text("Would you like to post this on the leaderboard?")
                    .fontWeight(.heavy)
                    .font(.system(size: 15))
                Button(action:{
                    popupPresented = false
                    leaderboardNavigate = true
                }) {
                    HStack {
                        Image(systemName: "checkmark.icloud.fill")
                           .font(.title3)
                        Text("Yes")
                            .font(.title3)
                    }
                    .frame(maxWidth: 320, maxHeight: 30)

                }
                .foregroundColor(Color("buttonForeground"))
                .buttonStyle(.borderedProminent)
                .tint(Color("buttonBackground"))
                
                Button(action:{
                    popupPresented = false
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                           .font(.title3)
                        Text("No")
                            .font(.title3)
                    }
                    .frame(maxWidth: 320, maxHeight: 30)

                }
                .foregroundColor(Color("buttonForeground"))
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
    }
}
