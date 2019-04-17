//
//  Stack.swift
//
//  Created by Chuck Krutsinger on 2/11/19.
//  Copyright © 2019 Countermind, LLC. MIT License.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this
//  software and associated documentation files (the "Software"), to deal in the Software
//  without restriction, including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  SOFTWARE.

public struct Stack<E> {
    
    private var array: [E] = []
    
    public init() { }
    
    ///Empty the stack
    public mutating func reset() {
        self.array = []
    }
    
    public mutating func push(_ element: E) {
        array.append(element)
    }
    
    public mutating func pop() -> E? {
        return array.popLast()
    }
    
    public func peek() -> E? {
        return array.last
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
}
