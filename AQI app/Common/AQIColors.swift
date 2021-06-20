//
//  AQIColors.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit

enum AQIIndex: String {
    case good = "Good"
    case satisfactory = "Satisfactory"
    case moderate = "Moderate"
    case poor = "Poor"
    case veryPoor = "Very Poor"
    case severe = "Severe"

    var color: UIColor {
        switch self {
        case .good:
            return UIColor(red: 0.0/255.0, green: 176.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        case .satisfactory:
            return UIColor(red: 146.0/255.0, green: 208.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        case .moderate:
            return UIColor(red: 250.0/255.0, green: 255.0/255.0, blue: 6.0/255.0, alpha: 1.0)
        case .poor:
            return UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .veryPoor:
            return UIColor(red: 255.0/255.0, green: 2.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .severe:
            return UIColor(red: 191.0/255.0, green: 1.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }
    
}

