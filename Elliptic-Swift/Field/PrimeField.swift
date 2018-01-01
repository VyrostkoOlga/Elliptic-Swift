//
//  PrimeField.swift
//  Elliptic-Swift
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import Foundation

class PrimeField: Field {
    
    // prime base of the field
    let p: Int
    
    init(prime: Int) {
        self.p = prime
    }
    
    func correct(element: Int) -> Int {
        let rest = element % p
        return rest >= 0 ? rest : rest + p
    }
    
    // operations
    
    func add(lhs: Int, rhs: Int) -> Int {
        return correct(element: lhs + rhs)
    }
    
    func sub(lhs: Int, rhs: Int) -> Int {
        return correct(element: lhs - rhs)
    }
    
    func mult(lhs: Int, rhs: Int) -> Int {
        return correct(element: lhs * rhs)
    }
    
    func pow(lhs: Int, rhs: Int) -> Int {
        // https://en.wikipedia.org/wiki/Exponentiation_by_squaring
        var result = 1
        var degree = rhs
        var lhs_degree = lhs
        while degree > 0 {
            if degree & 1 == 1 {
                result = mult(lhs: result, rhs: lhs_degree)
                degree -= 1
            }
            lhs_degree = mult(lhs: lhs_degree, rhs: lhs_degree)
            degree >>= 1
        }
        return result
    }
    
    // opposites
    
    func oppositeForSum(element: Int) -> Int {
        return correct(element: -element)
    }
    
    func oppositeForMult(element: Int) throws -> Int {
        // use extended euclidean algorithm to get
        // a linear combination of element and field's base
        // equals to 1 (element * u + p * v = 1), with field base
        // correction p * v disappears so we get element * u = 1
        // and u is an inverse for u
        
        let egcd_koef = try egcd(lhs: element, rhs: p)
        return correct(element: egcd_koef.1)
    }
    
}

// private supplementary

extension PrimeField {
    
    fileprivate func egcd(lhs: Int, rhs: Int) throws -> (Int, Int) {
        // https://brilliant.org/wiki/extended-euclidean-algorithm/
        // need to get 1 instead of 0 becase algorithm is used not for
        // finding greatest common divisor, but for finding koefficients
        // of lhs and rhs linear combination equals to 1
        
        var s = (0, 1)
        var t = (1, 0)
        var r = (rhs, lhs)
        while r.1 != 1 {
            let q = Int(r.0 / r.1)
            r = (r.1, r.0 - q * r.1)
            s = (s.1, s.0 - q * s.1)
            t = (t.1, t.0 - q * t.1)
            if r.1 == 0 {
                throw FieldError.noInverse(element: lhs)
            }
        }
        return (t.1, s.1)
    }
    
}


