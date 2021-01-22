//
//  WeatherManager.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import Foundation

class WeatherManager {
    
    private let networkService: NetworkService
    private let apiKey = "a593cb213cae3edd2f3454a6c01d8e9d"
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCurrentWeatherWith(cityName: String, completion: @escaping (Forecast) -> Void) {
        directGeocoding(city: cityName) { coordinate in
            let request = ForecastType.CurrentWeather(apiKey: self.apiKey, coordinates: coordinate).request
            print("REQUEST: -   \(request)")
            self.networkService.fetchJSONData(request: request, modelType: Forecast.self) { currentWeather in
                guard let currentWeather = currentWeather else { return }
                completion(currentWeather)
            }
        }
    }
    
//    func fetchFiveDayThreeHourForecastWith(cityName: String, completion: @escaping (Forecast) -> Void) {
//        let cityCoordinate = directGeocoding(city: cityName)
//        let request = ForecastType.FiveDayThreeHourForecast(apiKey: apiKey, coordinates: cityCoordinate).request
//
//        networkService.fetchJSONData(request: request, modelType: CurrentWeather.self) { fiveDayThreeHourForecast in
//            
//            print(fiveDayThreeHourForecast)
//            completion(fiveDayThreeHourForecast!)
//        }
//    }
    
    private func directGeocoding(city: String, completion: @escaping (Coordinate) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=\(apiKey)") else {
            completion(Coordinate(latitude: 0.0, longitude: 0.0))
            return
        }
        let request = URLRequest(url: url)
        
        networkService.fetchJSONData(request: request, modelType: [DirectGeocoding].self) { geocoding in
            guard let geocoding = geocoding?.first else { return }
            completion(Coordinate(latitude: geocoding.latitude, longitude: geocoding.longitude))
        }
    }
    
}
