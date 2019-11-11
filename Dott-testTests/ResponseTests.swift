//
//  ResponseTests.swift
//  Dott-testTests
//
//  Created by Damir Ramic on 11/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Dott_test

class ResponseTests: XCTestCase {
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let viewModel = VenueViewModel()
        XCTAssertTrue(viewModel.apiClient.url == Environments.VenuesUrl + "&categoryId=4d4b7105d754a06374d81259")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
