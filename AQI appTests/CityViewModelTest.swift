//
//  CityViewModelTests.swift
//  AQI appTests
//
//  Created by Vivek on 21/06/21.
//

import XCTest
@testable import AQI_app

class CityViewModelTest: XCTestCase {

    func testCityViewModel() {
       let city = City(name: "Agra", aqi: 234)
        let cityVM = CityViewModel(city)
        
        XCTAssertEqual(cityVM.name, "Agra")
        XCTAssertEqual(cityVM.aqiValue, "234")
    }

}
