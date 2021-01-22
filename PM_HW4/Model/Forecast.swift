//
//  WeatherResponse.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import Foundation

struct Forecast: Codable {
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let windDegrees: Int
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case windSpeed = "wind_speed"
        case windDegrees = "wind_deg"
        case weather
    }
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Daily: Codable {
    let dt: Int
    let temp: DailyTemperature
    let humidity: Int
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case humidity
        case weather
    }
}

struct DailyTemperature: Codable {
    let min: Double
    let max: Double
}
