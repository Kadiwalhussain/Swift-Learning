//
//  WeatherService.swift
//  Weatherly
//
//  Created on 2026-01-20.
//

import Foundation

class WeatherService: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Placeholder for future API integration
    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil
        
        // Simulated API call - replace with actual API integration
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Mock data for now
            self.weatherData = WeatherData(
                location: city,
                temperature: 72.0,
                condition: "Sunny",
                humidity: 65,
                windSpeed: 8.5,
                description: "Clear sky with light breeze"
            )
            self.isLoading = false
        }
    }
}
