//
//  CompositionTests.swift
//
//  Created by Chuck Krutsinger on 2/15/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import XCTest
@testable import CMUtilities

class CompositionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPipeForward() {
        XCTAssertEqual(1 |> incr, incr(1))
    }

    func testForwardComposeArrows() {
        XCTAssertEqual("\(square(incr(1)))", 1 |> incr >>> square >>> { "\($0)" })
    }
    
    func testForwardComposeDiamondSameType() {
        XCTAssertEqual(square(incr(1)), 1 |> incr <> square)
    }
    
    func testForwardComposeDiamondObjectMutation() {
        let setBackgroundBlue = setBackgroundColor(UIColor.blue)
        let button = UIButton()
        button |> setBackgroundBlue <> makeViewRound
        XCTAssertEqual(UIColor.blue, button.backgroundColor)
        XCTAssertTrue(button.layer.masksToBounds)
        XCTAssertEqual(button.layer.cornerRadius, button.frame.height / 2.0)
        XCTAssertTrue(button.clipsToBounds)
    }
    
    func testForwardComposeDiamonStructMutation() {
        let string = "string"
        var objectUnderTest = StructWithString(string: string)
        objectUnderTest |> toUpper <> exclaim
        XCTAssertEqual(objectUnderTest.string, "STRING!")
    }
    
    func testFishCompositionWithArrayToCaptureHiddenOuputSideEffects() {
        let result = 1 |> incrWithLog >=> squareWithLog
        let expectedCalc = ((1+1) * (1+1))
        let expectedLog = ["1 + 1 = 2", "2 * 2 = 4"]
        XCTAssertEqual(result.0, expectedCalc)
        XCTAssertEqual(result.1, expectedLog)
    }
    
    func testFishCompositionForChainingOptionals() {
        let fNil: (Int) -> Int? = { _ in nil }
        let gNil: (Int) -> Int? = { _ in nil }
        let fIdentity = { (x: Int) in x }
        let gIdentity = { (x: Int) in x }
        XCTAssertNil(1 |> fNil >=> gIdentity)
        XCTAssertNil(1 |> fIdentity >=> gNil)
        XCTAssertNil(1 |> fNil >=> gNil)
        XCTAssertEqual(1, 1 |> fIdentity >=> gIdentity)
    }
}

//Fixtures

fileprivate func incr<A: Numeric>(_ x: A) -> A {
    return x + 1
}

fileprivate func square<A: Numeric>(_ x: A) -> A {
    return x * x
}

fileprivate struct StructWithString {
    var string: String
}

fileprivate func toUpper(_ item: inout StructWithString) {
    item.string = item.string.uppercased()
}

fileprivate func exclaim(_ item: inout StructWithString) {
    item.string = item.string + "!"
}

fileprivate func incrWithLog<A: Numeric>(_ x: A)
              -> (A, [String])
{
    return (x + 1, ["\(x) + 1 = \(x + 1)"])
}

fileprivate func squareWithLog<A: Numeric>(_ x: A)
              -> (A, [String])
{
    return (x * x, ["\(x) * \(x) = \(x * x)"])
}
