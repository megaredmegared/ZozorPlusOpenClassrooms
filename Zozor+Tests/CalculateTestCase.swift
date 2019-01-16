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
    
    func testGiven2_WhenAdding4_ThenResultIs6() {
    calculate.stringNumbers.append("2")
        
    calculate.operators.append("+")
    calculate.stringNumbers.append("4")
        
    XCTAssertEqual(calculate.total(), 6.0)
    }

}
