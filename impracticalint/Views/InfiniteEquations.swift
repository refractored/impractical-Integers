//
//  InfiniteEquations.swift
//  impracticalint
//
//  Created by David M. Galvan on 2/16/23.
//

import SwiftUI


struct InfiniteEquations: View {
    @State var timeRemaining = 10
    @State var timeConfig = 10
    let countdown = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @AppStorage("infCorrectScore") private var infCorrectScore = 0
    @AppStorage("infIncorrectScore") private var infIncorrectScore = 0
    @State var ratioScore: Double = 0.0
    @State var sliderValue: Float = 2.0
    @State var attempts: Int = 0
    @State var equations = false
    @State var answer = ""
    @State var converted = ""
    @State var timer = -1
    @State var text = "Begin"
    @Environment(\.presentationMode) var presentationMode
    @State var currentInfo = equationInfo(terms: [Int](), answer: 0, displayText: "")
    var body: some View {
        
        VStack {
            
            Image(systemName: "infinity.circle.fill")
                .imageScale(.large)
                .foregroundColor(.red)
            Text("Infinity!")
            Divider()
                .frame(width: 200)
            
            if !equations{
                Text("Term Count:")
                    .font(.headline)
                Text("\(Int(sliderValue))").font(.title2).fontWeight(.thin)
                Slider(value: $sliderValue, in: 2...5) {
                } minimumValueLabel: {
                    Text("2").font(.callout).fontWeight(.thin)
                } maximumValueLabel: {
                    Text("5").font(.callout).fontWeight(.thin)
                }
                .frame(width: 125, height: 5)
                
                //if infCorrectScore != -1{
                    Text("C/I Ratio:")
                    Text("\(converted)").font(.title2).fontWeight(.thin)
                    .onAppear(perform: {
                         converted = String(format: "%.1f", (Double(infCorrectScore) / Double(infIncorrectScore)))
                    })
                //}
            }
            if equations {
                Text(String(timeRemaining))
                    .font(.largeTitle)
                    .onReceive(countdown){ time in
                        if timeRemaining > 0 {
                            
                            timeRemaining -= 1
                        }else{
                            infIncorrectScore += 1
                            timeRemaining = timeConfig
                            print("\(infCorrectScore) / \(infIncorrectScore)")
                            ratioScore = Double(infCorrectScore) / Double(infIncorrectScore)
                            currentInfo = generateEquation(termCount: Int(sliderValue))
                            
                            
                        }
                    }
                Text(currentInfo.displayText)
                TextField("Answer", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 125)
                    .modifier(jiggleEffect(animatableData: CGFloat(attempts)))
                    .multilineTextAlignment(.center)
                Button("Submit"){
                    if answer == String(currentInfo.answer){
                        infCorrectScore += 1
                        currentInfo = generateEquation(termCount: Int(sliderValue))
                        timeRemaining = timeConfig
                        answer = ""
                    } else {
                        infIncorrectScore += 1
                        withAnimation(.default){
                            attempts += 1
                            answer = ""
                        }
                    }
                }
                .foregroundColor(.white)
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            Button("\(text)") {
                if equations{
                    equations = false
                    text = "Begin"  
                } else {
                    equations = true
                    text = "End"
                    currentInfo = generateEquation(termCount: Int(sliderValue))
                    timeRemaining = 10
            }
//                if equations{
//                    equations = false
//                    text = "Begin"
//                } else {
//                    equations = true
//                    text = "End"
//                }
//                if equations{
//                    currentInfo = equationShuffle(termCount: Int(sliderValue))
//                    timeRemaining = 10
//
//                }
            }
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .tint(.red)
            if !equations{
                Button("Back"){
                    presentationMode.wrappedValue.dismiss()
                }
                .accentColor(.red)
                
            }
            
            
        }
        //            Text("TBA")
        //                .font(.largeTitle)
        //            Text("Correct/Incorrect Ratio")
        //                .font(.footnote)
    }
    
}



struct InfiniteEquations_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteEquations()
    }
}
