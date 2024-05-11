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

func generateEquation(termCount: Int) -> equationInfo{
    var equation = equationInfo(terms: [Int](), answer: 0, displayText: "")
    
    while equation.terms.count < termCount {
        let number = Int.random(in: -20 ... 20)
        equation.terms.append(number)
        
        // Looks less confusing with bigger equations.
        let numberString = number < 0 ? "(\(number))" : "\(number)"
        
        // Check if this is the first term, if so, make it equal to answer
        if equation.displayText.isEmpty{
            equation.answer = number
            equation.displayText += "\(numberString)"
            continue
        }
        
        // Run operations required to get the new answer if text is not empty.
        if Bool.random(){
            equation.answer += number
            equation.displayText += " + \(numberString)"
            continue
        }
        
        equation.answer -= number
        equation.displayText += " - \(numberString)"
        
    }
        return equation
}
