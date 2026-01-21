//
//  WeatherModel.swift
//  Weatherly
//
//  Created on 2026-01-20.
//

import Foundation

struct WeatherData: Codable {
    let location: String
    let temperature: Double
    let condition: String
    let humidity: Int
    let windSpeed: Double
    let description: String
}

struct WeatherResponse: Codable {
    let data: WeatherData
    let timestamp: Date
}
