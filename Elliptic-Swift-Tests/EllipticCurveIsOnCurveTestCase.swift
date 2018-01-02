//
//  EllipticCurveIsOnCurveTestCase.swift
//  Elliptic-Swift-Tests
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import XCTest

class EllipticCurveIsOnCurveTestCase: XCTestCase {

    var curve: EllipticCurve!
    
    override func setUp() {
        super.setUp()
        do {
            curve = try EllipticCurve(a: 4, b: 1, field: PrimeField(prime: 5))
        } catch { }
    }
    
    func testPointsOnCurve() {
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 1, y: 1, z: 1)))
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 0, y: 1, z: 1)))
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 0, y: 4, z: 1)))
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 3, y: 0, z: 1)))
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 4, y: 1, z: 1)))
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 4, y: 4, z: 1)))
    }
    
    func testPointsNotOnCurve() {
        XCTAssertFalse(curve.isOnCurve(point: Point(x: 3, y: 1, z: 1)))
        XCTAssertFalse(curve.isOnCurve(point: Point(x: 2, y: 2, z: 1)))
        XCTAssertFalse(curve.isOnCurve(point: Point(x: 4, y: 0, z: 1)))
        XCTAssertFalse(curve.isOnCurve(point: Point(x: 0, y: 2, z: 1)))
    }
    
    func testInfinity() {
        XCTAssertTrue(curve.isOnCurve(point: Point(x: 0, y: 1, z: 0)))
    }

}
