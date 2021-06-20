//
//  City.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import Foundation

struct City: Codable {
    
    //MARK:- Properties
    let name: String
    let aqi: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "city"
        case aqi
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        aqi = try values.decode(Double.self, forKey: .aqi)
    }
}
