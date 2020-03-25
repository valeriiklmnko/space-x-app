//
//  SpaceX_App_Tests.swift
//  SpaceX-App-Tests
//
//  Created by Valerii Klymenko on 22/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import XCTest
@testable import SpaceX_App

class SpaceX_App_Tests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetSpaceErrorMethod() {
        XCTAssertEqual(
            SpaceError.getSpaceError(statusCode: 200, data: nil),
            SpaceError.noData
        )
        XCTAssertEqual(
            SpaceError.getSpaceError(statusCode: 404, data: nil),
            SpaceError.pageNotFound
        )
        XCTAssertEqual(
            SpaceError.getSpaceError(statusCode: 500, data: nil),
            SpaceError.internalServerError
        )
        XCTAssertEqual(
            SpaceError.getSpaceError(statusCode: 1, data: nil),
            SpaceError.genericError
        )
        XCTAssertEqual(
            SpaceError.getSpaceError(statusCode: nil, data: nil),
            SpaceError.genericError
        )
    }
}


