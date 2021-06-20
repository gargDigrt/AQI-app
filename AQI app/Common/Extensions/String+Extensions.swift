//
//  String+Extensions.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import Foundation

extension String {
    
    
    /// This converts a string into an Array of dictionary.
    /// - Returns: An array of dictionary type
    func convertToDictionary() -> [[String: Any]]? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            let dict =  try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            return dict
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    /// This converts string into Data
    /// - Returns: An instance of Data type
    func toData() -> Data? {
        guard let data = data(using: .utf8) else { return nil }
        return data
    }
}

