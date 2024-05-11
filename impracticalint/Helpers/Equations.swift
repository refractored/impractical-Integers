//
//  TermHelpers.swift
//  impracticalint
//
//  Created by David G on 8/11/23.
//

import Foundation

struct equationInfo{
    var terms: [Int]
    var answer: Int
    var displayText: String
}

func generateEquation(termCount: Int) -> equationInfo {
    var equationData = equationInfo(terms: [Int](), answer: 0, displayText: "")
    
    while equationData.terms.count < termCount {
        let number = Int.random(in: -20 ... 20)
        equationData.terms.append(number)
        
        // Looks less neater with bigger equations.
        let numberString = number < 0 ? "(\(number))" : "\(number)"
        
        // Check if answer has been previously set before
        if (equationData.displayText.isEmpty){
            equationData.answer = number
            equationData.displayText += "\(numberString)"
            continue
        }
        
        // Run operations required to get the new answer if text is not empty.
        if Bool.random(){
            equationData.answer += number
            equationData.displayText += " + \(numberString)"
            continue
        }
        
        equationData.answer -= number
        equationData.displayText += " - \(numberString)"
        
    }
        return equationData
}
