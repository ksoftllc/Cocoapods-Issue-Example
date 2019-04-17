//
//  Composition.swift
//
//    MIT License
//
//    Copyright (c) 2017 Point-Free
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import Foundation
import Validated


precedencegroup ForwardComposition {
    associativity: left
    higherThan: SingleTypeComposition, EffectfulComposition
}

precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup SingleTypeComposition {
    associativity: right
    higherThan: ForwardApplication
}

precedencegroup ForwardApplication {
    associativity: left
}

/*
 Pipe Forward
 */
infix operator |>: ForwardApplication

/**
 Pipe the item on the left into the function on the right
 
 - Parameters:
     - x:   input
     - f:   operation to be performed on input
 
 - Returns: result of f(x)
 */
public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

/**
 Pipe the struct on the left into the function on the right as an inout parameter.
 
 - Parameters:
     - x:   input
     - f:   operation to be performed on input
 
 - Returns: result of f(x)
 */
func |> <A>(a: inout A, f: (inout A) -> Void) -> Void {
    f(&a)
}

/*
 Forward Composition
 */

infix operator >>>: ForwardComposition

/**
 Compose 2 functions f(A) -> B and g(B) -> C such that the resulting function is g(f(A)) -> C
 
 - Parameters:
     - f:   left side function
     - g:   right side function
 
 - Returns: function g(f(A)) -> C
 */
public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}


/*
 Single Type Composition
 */

/**
 This overload of the diamond operator forward composes (f >>> g) functions that operate on the same type.
 
 - Parameters:
     - f: left side function of form (A) -> A
     - g: right side function of form (A) -> A
 
 - Returns: function g(f(A)) -> A
 */
infix operator <>: SingleTypeComposition
public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
    return f >>> g
}

/**
 This overload of the diamond operator composes operations on an object type that return void by
 performing f then g functions sequentially.
 
 - Parameters:
 - f:   left side function of form (A) -> Void
 - g:   right side function of form (A) -> Void
 
 - Returns: function that performs f(A) then g(A)
 */
public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

/**
 This overload of the diamond operator composes mutating operations on structs by performing f then g
 functions sequentially.
 
 - Parameters:
     - f: left side struct mutating function of form (inout A) -> Void
     - g: right side struct mutating function of form (inout A) -> Void
 
 - Returns: function that performs f(A) then g(A)
 */
public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

/*
 Effectful Composition - Hidden outputs
 
 All of these compositions take a simple input and return a context-wrapped output.
 This can be useful for many things, including "railway oriented programming" composition (see https://fsharpforfunandprofit.com/rop/)
 which combines functions that take an input and produce either a Result<A,E> or a Validated<A,[E]>.
 Result<A,E> bypasses all remaining operations in the event of any failure.
 Validated<A,[E]> accumulates validation errors, if any in a non-empty array and keeps performing validations.
 */

infix operator >=>: EffectfulComposition

///Example "fish" operator is for composing functions that produce side effects of String type
public func >=> <A, B, C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
    ) -> ((A) -> (C, [String])) {
    
    return { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        return (c, logs + moreLogs)
    }
}

///Example "fish" operator for composing two functions that produce arrays
public func >=> <A, B, C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> [C]
    ) -> ((A) -> [C]) {
    
    return { a in
        return f(a).flatMap(g)
    }
}

/**
 "Fish" operator for composing two functions that produce optional results.
 
 - Parameters:
     - f: left side function that produces an optional
     - g: right side function that produces an optional
 
 - Returns: nil if either function returns nil, otherwise returns g(f(A)) -> C
 */
public func >=> <A, B, C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C?
    ) -> ((A) -> C?) {
    
    return { a in
        guard let b = f(a) else {
            return nil
        }
        return g(b)
    }
}
