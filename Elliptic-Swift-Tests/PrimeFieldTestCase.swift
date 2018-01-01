//
//  PrimeFieldTestCase.swift
//  Elliptic-Swift-Tests
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import XCTest

class PrimeFieldTestCase: XCTestCase {
    
    let pf = PrimeField(prime: 13)

    func testCorrectElement() {
        XCTAssertEqual(1, pf.correct(element: 1))
        XCTAssertEqual(5, pf.correct(element: 5))
        XCTAssertEqual(10, pf.correct(element: 10))
        XCTAssertEqual(0, pf.correct(element: 13))
        XCTAssertEqual(3, pf.correct(element: 16))
        XCTAssertEqual(7, pf.correct(element: -6))
        XCTAssertEqual(11, pf.correct(element: -15))
    }
    
    func testAdd() {
        XCTAssertEqual(1, pf.add(lhs: 0, rhs: 1))
        XCTAssertEqual(5, pf.add(lhs: 2, rhs: 3))
        XCTAssertEqual(12, pf.add(lhs: -7, rhs: 6))
        XCTAssertEqual(2, pf.add(lhs: 10, rhs: 5))
    }
    
    func testSub() {
        XCTAssertEqual(12, pf.sub(lhs: 0, rhs: 1))
        XCTAssertEqual(12, pf.sub(lhs: 2, rhs: 3))
        XCTAssertEqual(3, pf.sub(lhs: 7, rhs: 4))
        XCTAssertEqual(7, pf.sub(lhs: 14, rhs: 7))
        XCTAssertEqual(3, pf.sub(lhs: 18, rhs: 2))
    }
    
    func testMult() {
        XCTAssertEqual(0, pf.mult(lhs: 0, rhs: 1))
        XCTAssertEqual(6, pf.mult(lhs: 2, rhs: 3))
        XCTAssertEqual(2, pf.mult(lhs: 7, rhs: 4))
    }
    
    func testOppositeForMult() {
        XCTAssertEqual(8, try pf.oppositeForMult(element: 5))
        
    }

}
