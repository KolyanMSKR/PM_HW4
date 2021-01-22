//
//  Extension+Date.swift
//  PM_HW4
//
//  Created by Admin on 1/21/21.
//

import Foundation

extension Date {
    
    func toString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self as Date)
    }
    
}
