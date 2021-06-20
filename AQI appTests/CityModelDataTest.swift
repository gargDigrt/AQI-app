//
//  CityModelDataTest.swift
//  AQI appTests
//
//  Created by Vivek on 21/06/21.
//

import XCTest
@testable import AQI_app

class CityModelDataTest: XCTestCase {

    func testCityModelData() throws {
        let citiesText = "[{\"city\":\"Bengaluru\",\"aqi\":191.4267027326315},{\"city\":\"Delhi\",\"aqi\":303.1500690980988},{\"city\":\"Bhubaneswar\",\"aqi\":99.64753155344343},{\"city\":\"Chennai\",\"aqi\":140.84215228084184},{\"city\":\"Pune\",\"aqi\":223.13055293430668},{\"city\":\"Hyderabad\",\"aqi\":201.9179813989124},{\"city\":\"Indore\",\"aqi\":51.48420375230581},{\"city\":\"Jaipur\",\"aqi\":143.7944925559422}]"
        let cityData = citiesText.toData()
        let cities = try JSONDecoder().decode([City].self, from: cityData!)
        XCTAssertNotNil(cities)
        XCTAssertEqual(cities.count, 8)
    }
}
