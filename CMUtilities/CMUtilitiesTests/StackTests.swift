//
//  StackTests.swift
//
//  Created by Chuck Krutsinger on 2/11/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import XCTest
@testable import CMUtilities

class StackTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPeekValidWhenOneElementPushedOntoStack() {
        let first = "first"
        var stringStack = Stack<String>()
        stringStack.push(first)
        XCTAssertEqual(stringStack.peek()!, first)
    }
    
    func testPushedElementPopsLeavingEmptyStack() {
        let first = "first"
        var stringStack = Stack<String>()
        stringStack.push(first)
        let result = stringStack.pop()
        XCTAssertEqual(result, first)
        XCTAssertTrue(stringStack.isEmpty)
    }

    func testNilReturnedWhenPopAfterStackIsEmpty() {
        let first = "first"
        var stringStack = Stack<String>()
        stringStack.push(first)
        _ = stringStack.pop()
        XCTAssertTrue(stringStack.isEmpty)
        XCTAssertNil(stringStack.pop())
    }
    
    func testEmptyWhenResetIsPerformed() {
        var stringStack = Stack<String>()
        stringStack.push("first")
        stringStack.push("second")
        stringStack.reset()
        XCTAssertTrue(stringStack.isEmpty)
    }
    
}
