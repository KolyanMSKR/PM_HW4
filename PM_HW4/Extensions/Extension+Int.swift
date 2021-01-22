//
//  Extension+Int.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import Foundation

extension Int {
    
    func windDirection() -> String {
        let halfRange = 360/8/2
        let directions = ["↘️", "⬇️", "↙️", "⬅️", "↖️", "⬆️", "↗️", "➡️"]
        let direction = Int(-halfRange + self) / 45
        
        return directions[direction]
    }
    
    func toDateString(dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: date)
    }
    
}
