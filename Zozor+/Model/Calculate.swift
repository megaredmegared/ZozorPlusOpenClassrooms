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
        var total = 0.0
        var subTotal = 0.0
        var numbers = [0.0]
        
        // calculate with priorities
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                guard operators[i] == "÷" && number != 0 else {
                    throw CalculateError.cantDivideBy0
                }
                if operators[i] == "+" && operators[i+1] != "x" && operators[i+1] != "÷" {
                    numbers.append(number)
                } else if operators[i] == "-" && operators[i+1] != "x" && operators[i+1] != "÷" {
                    numbers.append(-number)
                } else if operators[i] == "x" && operators[i-1] != "+" && operators[i-1] != "-" {
                    subTotal = number * numbers.last!
                    numbers[numbers.count-1] = subTotal
                } else if operators[i] == "x" && operators[i-1] == "-" {
                    subTotal = number * Double(stringNumbers[i-1])!
                    numbers.append(-subTotal)
                } else if operators[i] == "x" {
                    subTotal = number * Double(stringNumbers[i-1])!
                    numbers.append(subTotal)
                } else if operators[i] == "÷" && operators[i-1] != "+" && operators[i-1] != "-" {
                    subTotal = numbers.last! / number
                    numbers[numbers.count-1] = subTotal
                } else if operators[i] == "÷" && operators[i-1] == "-"  {
                    subTotal = Double(stringNumbers[i-1])! / number
                    numbers.append(-subTotal)
                } else if operators[i] == "÷" {
                    subTotal = Double(stringNumbers[i-1])! / number
                    numbers.append(subTotal)
                }
            }
        }
        
        // calculate total
        for i in numbers {
            total += i
        }
        clear()
        return total
    }
    
    private func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
