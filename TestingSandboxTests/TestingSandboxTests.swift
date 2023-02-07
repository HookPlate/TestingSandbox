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
        do {
            try sut.goingToFail()
        } catch {
            XCTFail("The goingToFail method should not throw an error")
        }
        
    }
    
    func test_failingAsyncThrows() async throws {
        let sut = DataModel()
        
        do {
            try await sut.goingToFail()
        } catch {
            XCTFail("The goingToFail method should not throw an error")
        }
        
    }

}
