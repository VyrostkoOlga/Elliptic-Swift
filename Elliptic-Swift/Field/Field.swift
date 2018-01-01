//
//  Field.swift
//  Elliptic-Swift
//
//  Created by Olga Vyrostko on 01.01.18.
//  Copyright © 2018 OlgaVyrostko. All rights reserved.
//

import Foundation

enum FieldError: Error {
    
    case noInverse(element: Int)
    
}

protocol Field {
    
    // return base representation for the element of the field
    func correct(element: Int) -> Int
    
    // operations
    func add(lhs: Int, rhs: Int) -> Int
    func sub(lhs: Int, rhs: Int) -> Int
    func mult(lhs: Int, rhs: Int) -> Int
    
    // opposites for field operations,
    // for multiplication - if possible
    func oppositeForSum(element: Int) -> Int
    func oppositeForMult(element: Int) throws -> Int
    
}
