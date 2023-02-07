//
//  TestingSandboxTests.swift
//  TestingSandboxTests
//
//  Created by Yoli on 07/02/2023.
//gives us access to things we wouldn't normally have access to. 
@testable import TestingSandbox
import XCTest

final class TestingSandboxTests: XCTestCase {
//sut = system under test.
    func test_failingThrows() throws {
        let sut = DataModel()
        //clearer to catch any errors and print since when in 6 months time we make some changes it's a lot clearer as to what's happening.
        do {
            try sut.goingToFail()
            //I think judging from the doc these are considered assertions. What we do when something goes wrong.
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
