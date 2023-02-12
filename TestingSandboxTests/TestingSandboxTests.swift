//
//  TestingSandboxTests.swift
//  TestingSandboxTests
//
//  Created by Yoli on 07/02/2023.
@testable import TestingSandbox
import XCTest
//if you want to you could make the whole class @MainActor and now every test case insde there will now also run only on that main thread. 
final class TestingSandboxTests: XCTestCase {
    func test_failingThrows() throws {
        let sut = DataModel()
        try XCTAssertThrowsError(sut.goingToFail(), "The goingToFail method should have thrown an error.")
    
    }
    //used if you know the test will be passed code the affects the UI nad therefore needs to be run on the main thread.
    @MainActor
    func test_failingAsyncThrows() async throws {
        let sut = DataModel()
        try await XCTAssertThrowsError( await sut.goingToFail(), "The goingToFail method should have thrown an error.")
        
    }
}

//so this is anothoer signature, why is this funciton loose outside the class.
func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    if let _ = try? await expression() {
        XCTFail(message(), file: file, line: line)
    }
}

