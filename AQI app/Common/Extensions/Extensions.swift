//
//  Extensions.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit


extension UIViewController {
    
    /// An identifier of type string.
    /// It's value will be same as name of subclass of UIViewController.
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    /// An identifier of type string.
    /// It's value will be same as name of subclass of UITableViewCell.
    static var identifier: String {
        return String(describing: self)
    }
}
