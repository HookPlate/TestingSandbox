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

        XCTAssertSendsChangeNotification(sut.flag.toggle(), from: sut, "Flipping DataModel.flag should trigger a change notification.")
    }
}


func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) async {
    if let _ = try? await expression() {
        XCTFail(message(), file: file, line: line)
    }
}

func XCTAssertSendsChangeNotification<T, U: ObservableObject>(_ expression: @autoclosure () -> T, from object: U, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
    var changePublished = false

    let checker = object.objectWillChange.sink { _ in
        changePublished = true
    }

    _ = checker
    _ = expression()

    XCTAssertTrue(changePublished, message(), file: file, line: line)
}

