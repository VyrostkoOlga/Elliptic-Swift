//
//  EllipticCurveAdditionTestCase.swift
//  Elliptic-Swift-Tests
//
//  Created by Olga Vyrostko on 02.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import XCTest

class EllipticCurveAdditionTestCase: XCTestCase {
    
    var curve: EllipticCurve!
    
    override func setUp() {
        super.setUp()
        do {
            curve = try EllipticCurve(a: 1, b: 1, field: PrimeField(prime: 23))
        } catch { }
    }
    
    func testAdditionSimpleCases() throws {
        XCTAssertEqual(Point(x: 17, y: 3, z: 1), try curve.add(p1: Point(x: 1, y: 7, z: 1), p2: Point(x: 0, y: 22, z: 1)))
        XCTAssertEqual(Point(x: 17, y: 20, z: 1), try curve.add(p1: Point(x: 3, y: 10, z: 1), p2: Point(x: 9, y: 7, z: 1)))
    }
    
    func testAdditionWithInfinity() throws {
        XCTAssertEqual(Point(x: 1, y: 7, z: 1), try curve.add(p1: Point(x: 1, y: 7, z: 1), p2: Point(x: 0, y: 22, z: 0)))
        XCTAssertEqual(Point(x: 9, y: 7, z: 1), try curve.add(p1: Point(x: 3, y: 10, z: 0), p2: Point(x: 9, y: 7, z: 1)))
    }
    
    func testOppositePointsAddition() throws {
        XCTAssertEqual(Point(x: 0, y: 1, z: 0), try curve.add(p1: Point(x: 1, y: 7, z: 1), p2: Point(x: 1, y: 16, z: 1)))
    }

}
