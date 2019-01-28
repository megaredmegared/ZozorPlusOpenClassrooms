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
    
    /// testing of adding decimal separator at start should put a 0 before the separator
    func testGivenNumberIsVoid_WhenAddingDecimalSeparatorAnd6_ThenStringNumbersIs0Point6() {
        calculate.stringNumbers = [""]
        
        try! calculate.addDecimalSeparator(".")
        calculate.addNewNumber(6)
        
        XCTAssertEqual(calculate.stringNumbers[0], "0.6")
    }
    
    /// testing of adding numbers with decimal separator
    func testGivenNumberIs4_WhenAddingDecimalSeparatorAnd6_ThenStringNumbersIs4Point6() {
        calculate.stringNumbers = ["4"]
        
        try! calculate.addDecimalSeparator(".")
        calculate.addNewNumber(6)
        
        XCTAssertEqual(calculate.stringNumbers[0], "4.6")
    }
    
    /// testing of addition
    func testGivenStartNumberIs0Point1_WhenAdding0Point2_ThenResultIs0Point3() {
        calculate.stringNumbers = ["0.1"]
        
        calculate.operators.append("+")
        calculate.stringNumbers.append("0.2")
        
        XCTAssertEqual(try calculate.total(), 0.3)
    }
    
    /// testing of multiplication
    func testGivenStartNumberIs4Point2_WhenMultiplyBy4Point5_ThenResultIs8() {
        calculate.stringNumbers = ["4.2"]
        
        calculate.operators.append("x")
        calculate.stringNumbers.append("4.5")
        
        XCTAssertEqual(try calculate.total(), 18.9)
    }
    
    /// testing of division
    func testGivenStartNumberIs4Point2_DivideBy4Point5_ThenResultIs0Point84() {
        calculate.stringNumbers = ["4.2"]
        
        calculate.operators.append("÷")
        calculate.stringNumbers.append("5")
        
        XCTAssertEqual(try calculate.total(), 0.84)
    }
    
    /// testing of substraction
    func testGivenStartNumberIs23_WhenSubtracting12_ThenResultIs11() {
        calculate.stringNumbers = ["23"]
        
        calculate.operators.append("-")
        calculate.stringNumbers.append("12")
        
        XCTAssertEqual(try calculate.total(), 11.0)
    }
    
}
