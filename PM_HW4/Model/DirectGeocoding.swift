//
//  DirectGeocoding.swift
//  PM_HW4
//
//  Created by Admin on 1/20/21.
//

import Foundation

struct DirectGeocoding: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
        case country
    }
}
