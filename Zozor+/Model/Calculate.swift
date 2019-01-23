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

    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    func addNewOperator(_ newOperator: String) throws {
        guard canAddOperator else {
            throw CalculateError.cantAddOperator
        }
        operators.append(newOperator)
        stringNumbers.append("")
    }
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func total() throws -> Double {
        guard isExpressionCorrect else {
            throw CalculateError.expressionIncorrect
        }
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
        clear()
        return total
    }
    
    private func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
