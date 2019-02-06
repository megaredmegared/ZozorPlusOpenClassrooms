//
//  Calculate.swift
//  CountOnMe
//
//  Created by megared on 14/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

/// Contain all the functions for the calcul to work properly
class Calculate {
    /// Contain all the operators tapped for the calcul
    var operators = ["+"]
    /// Contain all the numbers tapped for the calcul
    var stringNumbers = [""]
    /// Contain the decimal separator
    var decimalSeparator = ""
    
    /// A Bool that check if we can add a number
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    /// A Bool that check if we can add an operator
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    /// A Bool that check if we can add a decimal separator
    var canAddDecimalSeparator: Bool {
        for separator in stringNumbers.last! {
            if separator == "." {
                return false
            }
        }
        return true
    }
    
    /// Add an operator and trigger an error if it is not possible
    func addNewOperator(_ newOperator: String) throws {
        guard canAddOperator else {
            throw CalculateError.cantAddOperator
        }
        operators.append(newOperator)
        stringNumbers.append("")
    }
    
    /// Clear the decimal operator
    func clearDecimalSeparator() {
        decimalSeparator = ""
    }
    
    /// Add a decimal separator and triggger an error if it is not possible
    func addDecimalSeparator(_ separator: String) throws {
        guard canAddDecimalSeparator else {
            throw CalculateError.cantAddDecimalSeparator
        }
        decimalSeparator = separator
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            if stringNumber == "" {
                stringNumberMutable += "0\(decimalSeparator)"
            } else {
                stringNumberMutable += decimalSeparator
            }
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        clearDecimalSeparator()
    }
    
    /// Add a number
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    /// Calculation of the total of the operations with Decimal for precise math operations
    func total() throws -> Decimal {
        guard isExpressionCorrect else {
            if stringNumbers.count == 1 {
                throw CalculateError.expressionIncorrectStartNewOperation
            } else {
                throw CalculateError.expressionIncorrect
            }
        }
   
        var numbers: [Double] = [0]
        
        // Calculate with priorities
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if let lastNumber = numbers.last {
                    if operators[i] == "+" {
                        numbers.append(number)
                    } else if operators[i] == "-" {
                        numbers.append(-number)
                    }
                    else if operators[i] == "x" {
                        numbers[numbers.count-1] = lastNumber * number
                    } else if operators[i] == "÷" {
                        guard number != 0 else {
                            clear()
                            throw CalculateError.cantDivideBy0
                        }
                        numbers[numbers.count-1] = lastNumber / number
                    }
                }
            }
        }
 
        clear()
        // Return the sum of numbers then round it and transform in Decimal for correct presentation
        return Decimal(round(1000*numbers.reduce(0.0, +))/1000)
    }
    
    /// Put back in starting setup state
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        clearDecimalSeparator()
    }
}
