//
//  CityViewModel.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit

struct CityViewModel {
    
    //Private properties
    private var city: City!
    private var status: String!
    private var color: UIColor!
    
    
    /// This will initialize an instance of CityViewModel
    /// - Parameter city: In instance of Model City
    init(_ city: City) {
        self.city = city
        let aqiResult = checkForAQIRange()
        status = aqiResult.rawValue
        color = aqiResult.color
    }
}

//MARK:- Properties
extension CityViewModel {
    
    var name: String {
        return city.name
    }
    
    var aqiValue: String {
        let value = Int(city.aqi)
        return "\(value)"
    }
    
    var aqiStatus: String {
        return self.status
    }
    
    var aqiColor: UIColor {
        return color
    }
    
}

//MARK:- Behaviour
extension CityViewModel {
    
    func checkForAQIRange() -> AQIIndex{
        switch city.aqi {
        case 0...51:
            return .good
        case 51...101:
            return .satisfactory
        case 101...201:
            return .moderate
        case 201...301:
            return .poor
        case 301...401:
            return .veryPoor
        case 401...500:
            return .severe
        default:
            return .good
        }
    }
}
