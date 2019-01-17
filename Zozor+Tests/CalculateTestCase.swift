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
    
    func testGivenStartNumberIs2_WhenAdding4_ThenResultIs6() {
    calculate.stringNumbers = ["2"]
        
    calculate.operators.append("+")
    calculate.stringNumbers.append("4")
        
    XCTAssertEqual(calculate.total(), 6.0)
    }
    
    func testGivenStartNumberIs4_WhenMultiplyBy4_ThenResultIs8() {
    calculate.stringNumbers = ["4"]
        
    calculate.operators.append("x")
    calculate.stringNumbers.append("4")
    
    XCTAssertEqual(calculate.total(), 16.0)
    }
    
    func testGivenStartNumberIs3_DivideBy2_ThenResultIs1Point5() {
        calculate.stringNumbers = ["3"]
        
        calculate.operators.append("÷")
        calculate.stringNumbers.append("2")
        
        XCTAssertEqual(calculate.total(), 1.5)
    }
    
    func testGivenStartNumberIs23_WhenSubtracting12_ThenResultIs11() {
        calculate.stringNumbers = ["23"]
        
        calculate.operators.append("-")
        calculate.stringNumbers.append("12")
        
        XCTAssertEqual(calculate.total(), 11.0)
    }

}
