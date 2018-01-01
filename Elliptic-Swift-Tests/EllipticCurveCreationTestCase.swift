//
//  EllipticCurveCreationTestCase.swift
//  Elliptic-Swift-Tests
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import XCTest

class EllipticCurveCreationTestCase: XCTestCase {

    func testEllipticCurveCreation() throws {
        let field = PrimeField(prime: 5)
        
        XCTAssertNoThrow(try EllipticCurve(a: -3, b: 1, field: field))
        
        do {
            let _ = try EllipticCurve(a: -3, b: 3, field: field)
            XCTAssertFalse(false)
        } catch EllipticCurveError.specialCurve { }
    }

}
