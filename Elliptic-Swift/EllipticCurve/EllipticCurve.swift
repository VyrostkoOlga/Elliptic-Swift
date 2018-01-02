//
//  EllipticCurve.swift
//  Elliptic-Swift
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import Foundation

enum EllipticCurveError: Error {
    
    case specialCurve
    
}

struct Point {
    // projective point
    // z = 0 -> point representing infinity
    
    let x: Int
    let y: Int
    let z: Int
    
    func isInfinity() -> Bool {
        return z == 0
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        if lhs.isInfinity() {
            return rhs.isInfinity()
        }
        if rhs.isInfinity() {
            return lhs.isInfinity()
        }
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

class EllipticCurve {
    
    // params of curve equation
    // y^2 ≡ x^3 + ax + b
    
    let a: Int
    let b: Int
    
    // underlying field
    let field: Field
    
    init(a: Int, b: Int, field: Field) throws {
        self.a = a
        self.b = b
        self.field = field
        if isSpecial() {
            throw EllipticCurveError.specialCurve
        }
    }
    
    func isSpecial() -> Bool {
        var result = field.pow(lhs: a, rhs: 3)
        result = field.mult(lhs: 4, rhs: result)
        
        let b_part = field.mult(lhs: 27, rhs: field.pow(lhs: b, rhs: 2))
        result = field.add(lhs: result, rhs: b_part)
        return result == 0
    }
    
    func isOnCurve(point: Point) -> Bool {
        if point.isInfinity() {
            return true
        }
        
        // check using curve equation
        let left = field.mult(lhs: point.y, rhs: point.y)
        var right = field.mult(lhs: field.mult(lhs: point.x, rhs: point.x), rhs: point.x)
        right = field.add(lhs: right, rhs: field.mult(lhs: a, rhs: point.x))
        right = field.add(lhs: right, rhs: b)
        return left == right
    }
    
}
