//
//  CalculateTestCase.swift
//  CountOnMeTests
//
//  Created by megared on 14/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculateTestCase: XCTestCase {
    var calculate: Calculate!
    
    override func setUp() {
        super.setUp()
        calculate = Calculate()
    }
    
    /// Testing of adding decimal separator at start should put a 0 before the separator
    func testGivenNumberIsVoid_WhenAddingDecimalSeparatorAnd6_ThenNumbersIs0Point6() {
        calculate.stringNumbers = [""]
        
        try! calculate.addDecimalSeparator(".")
        calculate.addNewNumber(6)
        
        XCTAssertEqual(calculate.stringNumbers[0], "0.6")
    }
    
    
    /// Testing of adding numbers with decimal separator
    func testGivenNumberIs4_WhenAddingDecimalSeparatorAnd6_ThenStringNumbersIs4Point6() {
        calculate.stringNumbers = ["4"]
        
        try! calculate.addDecimalSeparator(".")
        calculate.addNewNumber(6)
        
        XCTAssertEqual(calculate.stringNumbers[0], "4.6")
        
    }
    
    /// Testing adding a decimal separator when there is already one should trigger an error
    func testGivenAddedNumberIs4Point2_WhenAddingDecimalSeparator_ThenTriggerCantAddDecimalSeparatorError() {
        calculate.stringNumbers.append("4.2")
        
        XCTAssertThrowsError( try calculate.addDecimalSeparator("x")) { error in
            XCTAssertEqual(error as! CalculateError, CalculateError.cantAddDecimalSeparator)
        }
    }
    
    /// Testing divide by 0 trigger an error
    func testGivenNumberIs5_WhenDivideBy0_ThenTriggerADivideBy0Error() {
        calculate.stringNumbers = ["5"]
        
        calculate.operators.append("÷")
        calculate.stringNumbers.append("0")
        
        XCTAssertThrowsError( try calculate.total()) { error in
            XCTAssertEqual(error as! CalculateError, CalculateError.cantDivideBy0)
        }
    }
    
    /// Testing of addition
    func testGivenNumberIs0Point1_WhenAdding0Point2_ThenResultIs0Point3() {
        calculate.stringNumbers = ["0.1"]
        
        calculate.operators.append("+")
        calculate.stringNumbers.append("0.2")
        
        XCTAssertEqual(try calculate.total(), 0.3)
    }
    
    /// Testing of multiplication
    func testGivenNumberIs4Point2_WhenMultiplyBy4Point5_ThenResultIs8() {
        calculate.stringNumbers = ["4.2"]
        
        calculate.operators.append("x")
        calculate.stringNumbers.append("4.5")
        
        XCTAssertEqual(try calculate.total(), 18.9)
    }
    
    /// Testing of division
    func testGivenNumberIs4Point2_DivideBy4Point5_ThenResultIs0Point84() {
        calculate.stringNumbers = ["4.2"]
        
        calculate.operators.append("÷")
        calculate.stringNumbers.append("5")
        
        XCTAssertEqual(try calculate.total(), 0.84)
    }
    
    /// Testing of substraction
    func testGivenNumberIs23_WhenSubtracting12_ThenResultIs11() {
        calculate.stringNumbers = ["23"]
        
        calculate.operators.append("-")
        calculate.stringNumbers.append("12")
        
        XCTAssertEqual(try calculate.total(), 11)
    }
    
    /// Testing the clear action
    func testGivenNumberIs23Point12_WhenClear_ThenNumberIsAVoidString() {
        calculate.stringNumbers = ["23"]
        
        calculate.clear()
        
        XCTAssertEqual(calculate.stringNumbers, [""])
        XCTAssertEqual(calculate.operators, ["+"])
        XCTAssertEqual(calculate.decimalSeparator, "")
    }
    
    /// Testing throw an error if we try to put a second operator
    func testGivenCalculIs4Multiply_WhenAddingAnewOperator_ThenAErrorMessageIsTriggered() {
        calculate.stringNumbers = ["4"]
        try! calculate.addNewOperator("x")
        
        XCTAssertThrowsError(try calculate.addNewOperator("+")) { error in
            XCTAssertEqual(error as! CalculateError, CalculateError.cantAddOperator)
        }
    }
    
    /// Testing throw an error if we try to calculate total and there is no number
    func testGivenThereIsNoNumber_WhenTryToMakeCalculation_ThenTriggerAnExpressionIncorrectStartNewOperationError() {
        calculate.stringNumbers = [""]
        
        XCTAssertThrowsError(try calculate.total()) { error in
            XCTAssertEqual(error as! CalculateError, CalculateError.expressionIncorrectStartNewOperation)
        }
    }
    
    /// Testing throw an error if we try to calculate total and there is no number at the end of operation
    func testGivenCalculIs4Multiply_WhenTryToMakeCalculation_ThenTriggerAnExpressionIncorrectError() {
        calculate.stringNumbers = ["4"]
        try! calculate.addNewOperator("x")
        
        XCTAssertThrowsError(try calculate.total()) { error in
            XCTAssertEqual(error as! CalculateError, CalculateError.expressionIncorrect)
        }
    }
}
