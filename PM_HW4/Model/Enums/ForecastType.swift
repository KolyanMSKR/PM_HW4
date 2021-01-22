//
//  ForecastType.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

enum ForecastType {
    
    case CurrentWeather(apiKey: String, coordinates: Coordinate)
//    case FiveDayThreeHourForecast(apiKey: String, coordinates: Coordinate)
    
    private var baseUrl: URL? {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/")
        return url!
    }
    
    private var endPoint: String {
        switch self {
        case .CurrentWeather(let apiKey, let coordinates):
            return "onecall?units=metric&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly,minutely&appid=\(apiKey)"
            
//        case .FiveDayThreeHourForecast(let apiKey, let coordinates):
//            return "forecast?units=metric&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: endPoint, relativeTo: baseUrl)
        return URLRequest(url: url!)
    }
    
}



