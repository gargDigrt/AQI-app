//
//  CityListUITests.swift
//  AQI appUITests
//
//  Created by Vivek on 21/06/21.
//

import XCTest

class CityListUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityListWithAQIIsVisiable() {
        app.launch()
        
        let cityListTableView = app.tables["table--cityListTableView"]
        XCTAssertTrue(cityListTableView.exists, "The city list with AQI exists.")
    }
    
    func testCitySelection() {
        app.launch()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        let cityListTableView = app.tables["table--cityListTableView"]
        XCTAssertFalse(cityListTableView.exists, "The city list with AQI exists.")
    }

}
