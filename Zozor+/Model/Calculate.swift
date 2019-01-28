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
    var decimalSeparator = ""
    
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
    
    var canAddDecimalSeparator: Bool {
        for separator in stringNumbers.last! {
            if separator == "." {
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
    func clearDecimalSeparator() {
        decimalSeparator = ""
    }
    
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
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func total() throws -> Decimal {
        guard isExpressionCorrect else {
            throw CalculateError.expressionIncorrect
        }
        
        var numbers = [Decimal(floatLiteral: 0.0)]
        
        // calculate with priorities
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if let lastNumber = numbers.last {
                    if operators[i] == "+" {
                        numbers.append(Decimal(floatLiteral: number))
                    } else if operators[i] == "-" {
                        numbers.append(Decimal(floatLiteral: -number))
                    }
                    else if operators[i] == "x" {
                        numbers[numbers.count-1] = lastNumber * Decimal(floatLiteral: number)
                    } else if operators[i] == "÷" {
                        guard number != 0 else {
                            clear()
                            throw CalculateError.cantDivideBy0
                        }
                        numbers[numbers.count-1] = lastNumber / Decimal(floatLiteral: number)
                    }
                }
                else {
                    print("Error number.last out of range")
                }
            }
        }
 
        clear()
        // return the sum of numbers
        return numbers.reduce(Decimal(floatLiteral: 0.0), +)
    }
    /// Put back in starting setup
    private func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
