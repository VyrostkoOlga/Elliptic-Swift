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
    case pointIsNotOnCurve(Point)
    
}

struct Point: Equatable {
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
        // only for pceudo-random curves
        // check if 4*(a^2) + 27*(b^2) == 0
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
    
    func add(p1: Point, p2: Point) throws -> Point {
        // step 1: check that points are on curve -
        // if not, addition is not supported
        if !isOnCurve(point: p1) {
            throw EllipticCurveError.pointIsNotOnCurve(p1)
        }
        if !isOnCurve(point: p2) {
            throw EllipticCurveError.pointIsNotOnCurve(p2)
        }
        
        // step 2: infinity is neutral element for addition
        if p1.isInfinity() {
            return p2
        }
        if p2.isInfinity() {
            return p1
        }
        
        // step 3: check if points are equal,
        // if so, special formulas for doubling
        // points should be used
        if p1 == p2 {
            return double(p: p1)
        }
        
        // step 4: check if points are opposite on curve,
        // if so, their sum is equal to infinity
        if areOppositePoints(p1: p1, p2: p2) {
            return Point(x: 0, y: 1, z: 0)
        }
        
        // after all special cases checks, use simple
        // formulas for addition
        var lambda = field.sub(lhs: p2.y, rhs: p1.y)
        let lambda_inv = try field.oppositeForMult(element: field.sub(lhs: p2.x, rhs: p1.x))
        lambda = field.mult(lhs: lambda, rhs: lambda_inv)
        
        var res_x = field.sub(lhs: field.correct(element: -p1.x), rhs: p2.x)
        let double_lambda = field.pow(lhs: lambda, rhs: 2)
        res_x = field.add(lhs: res_x, rhs: double_lambda)
        
        var res_y = field.sub(lhs: res_x, rhs: p1.x)
        res_y = field.mult(lhs: res_y, rhs: lambda)
        res_y = field.add(lhs: p1.y, rhs: res_y)
        return Point(x: res_x, y: field.correct(element: -res_y), z: 1)
    }
    
    private func double(p: Point) -> Point {
        return p
    }
    
    private func areOppositePoints(p1: Point, p2: Point) -> Bool {
        // checks if points are opposite on this curve,
        // for curves like pseudo-random (see NIST_FIPS_186-4, page 89)
        // opposite points are (x, y) and (x, -y)
        return !p1.isInfinity() && !p2.isInfinity() && p1.y == field.correct(element: -p2.y)
    }
    
}
