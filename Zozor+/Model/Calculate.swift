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
            // Limit the lenght of the entered number
            var stringNumberLenght = stringNumber.count
            // Check if there is a decimal separator to adjust the lenght
            if stringNumber.contains(".") {
                stringNumberLenght += -1
            }
            // the limit of digit is decided here
            if stringNumberLenght < 16 {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "\(newNumber)"
                stringNumbers[stringNumbers.count-1] = stringNumberMutable
            }
        }
    }
    
    /// Calculation of the total of the operations with Decimal for precise math operations
    func total() throws -> String {
        guard isExpressionCorrect else {
            if stringNumbers.count == 1 {
                throw CalculateError.expressionIncorrectStartNewOperation
            } else {
                throw CalculateError.expressionIncorrect
            }
        }
        
        var numbers: [Double] = [0]
        var total: Double = 0
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
        
        // The result of sum of numbers
        total = numbers.reduce(0.0, +)
        
        // Check if result is a not a too big number and throw an error if it's the case
        guard total.isFinite else {
            throw CalculateError.resultIsTooBig
        }
        
        // The precision is the number of decimal after decimal separator
        let precision: Double = 9
        
        // The result of sum of numbers rounded with the precision wanted
        let result: Double = round(pow(10, precision)*total) / pow(10, precision)

        // Return the result in "String" and if it end by .0 remove it
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(result).replacingOccurrences(of: ".0", with: "")
        } else {
            return String(result)
        }
    }
    
    /// Put back in starting setup state
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        clearDecimalSeparator()
    }
}
