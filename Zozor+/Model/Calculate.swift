//
//  Calculate.swift
//  CountOnMe
//
//  Created by megared on 14/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculate {
    var operators: [String] = ["+"]
    var stringNumbers: [String] = [String()]
        
    func total() -> Double {
        var total: Double = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                } else if operators[i] == "÷" {
                    total /= number
                } else if operators[i] == "x" {
                    total *= number
                }
            }
        }
        return total
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        //        index = 0
    }
}
