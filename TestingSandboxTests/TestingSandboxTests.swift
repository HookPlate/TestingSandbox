//
//  TestingSandboxTests.swift
//  TestingSandboxTests
//
//  Created by Yoli on 07/02/2023.
@testable import TestingSandbox
import XCTest

final class TestingSandboxTests: XCTestCase {
    func test_failingThrows() throws {
        let sut = DataModel()
        //this one expects to fail and if it doesn't then that's bad and will print the string.
        try XCTAssertThrowsError(sut.goingToFail(), "The goingToFail method should have thrown an error.")
    
    }
    
    func test_failingAsyncThrows() async throws {
        let sut = DataModel()
        //having set up the bottom function we can now add await here and it'll succeed.
        try await XCTAssertThrowsError( await sut.goingToFail(), "The goingToFail method should have thrown an error.")
        
    }
}

//what we're saying here is that our function is generic over some kind of T - whatever our test code will return (our sut'goingToFail' we don't care hence the generic). We then provide the expression we want to evaluate, sut.goinfToFail - it'll be asynchronous and it will trow errors potantially and it will return something or nothong (could be void). This expression uses the autoclosure attriubute, what we're saying here is: when `swift sees the sutGoingToFail, where not saying 'run this immediately and pass it's return value into our function' what we're saying is: 'turn this into a closure quietly - become effectively this: { sutGoingToFail } - don't run it now, run it later on when we're ready for it.' So stash it away to be run, not at the call site but later on. Then the message string is also an autoclosure() 'do not evaluate this straight away because it could be a function to evaluate the message string, we don't know.' We then use the 'file' and 'line' compiler directives saying 'insert the correct path and insert the correct line number. These are used so it reports good errors messages in the debug area (having called this thing say it'll be user/home/testingSandBox/etcc... and line will be whatever line it's being called on) The type for those things is fairly rarely used swift type StaticString meaning a string that's been hard coded so you can't use string interpolation here, it needs to be typed into the compiler directly.
//That the signature, Inside there it more trivial code: try running the expression (sutGoingToFail()) now, we're ready for it, if it worked, great, that means things have gone wrong, call a failer, this thing should throw an error if all is well with your code.
//phew, after all that we can run the test and it gives is test succeeded. 
func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    if let _ = try? await expression() {
        XCTFail(message(), file: file, line: line)
    }
}

