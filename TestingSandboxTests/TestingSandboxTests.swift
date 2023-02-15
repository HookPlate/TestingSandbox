//
//  TestingSandboxTests.swift
//  TestingSandboxTests
//
//  Created by Yoli on 07/02/2023.
@testable import TestingSandbox
import XCTest

@MainActor
final class TestingSandboxTests: XCTestCase {
    func test_failingThrows() throws {
        let sut = DataModel()
        try XCTAssertThrowsError(sut.goingToFail(), "The goingToFail method should have thrown an error.")
    
    }

   
    func test_failingAsyncThrows() async throws {
        let sut = DataModel()
        try await XCTAssertThrowsError( await sut.goingToFail(), "The goingToFail method should have thrown an error.")
        
    }
    
    func test_flagChangesArePublished() {
        let sut = DataModel()
        var flagChangePublished = false
        
        //we now look for the chnage announcement coming through. Can use _ for checker if you want to get rid of warning but that will mean it's not stored aywhere and then it'll crassh when we try running the code.
        let checker = sut.objectWillChange.sink {
            //when it you have changed tell me and do the below.
            flagChangePublished = true
        }
        //so in the DataModel it starts false, when we run this method the below flips the flag in the the class, that makes the checker closer =kick in the which changes our local flagChangePublished variable.
        sut.flag.toggle()
        
        //We can now assert.
        XCTAssertTrue(flagChangePublished, "Flipping DataModal.flag should trigger a change notification.")
    }
}


func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    if let _ = try? await expression() {
        XCTFail(message(), file: file, line: line)
    }
}

