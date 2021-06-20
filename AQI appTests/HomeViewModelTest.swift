//
//  HomeViewModelTest.swift
//  AQI appTests
//
//  Created by Vivek on 21/06/21.
//

import XCTest
@testable import AQI_app

class HomeViewModelTest: XCTestCase {

    func testHomeViewModel() {
        let homeVW = HomeViewModel()
        XCTAssertNotNil(homeVW.socketManager)
    }
}
