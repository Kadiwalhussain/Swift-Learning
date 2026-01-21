//
//  ContentView.swift
//  Weatherly
//
//  Created on 2026-01-20.
//

import SwiftUI

struct ContentView: View {
    @State private var cityName: String = "New York"
    @State private var temperature: Double = 72.0
    @State private var condition: String = "Sunny"
    @State private var humidity: Int = 65
    @State private var windSpeed: Double = 8.5
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App Title
                Text("Weatherly")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Spacer()
                
                // City Name
                Text(cityName)
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(.white)
                
                // Temperature
                Text("\(Int(temperature))°F")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundColor(.white)
                
                // Weather Condition
                Text(condition)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                // Weather Details Card
                VStack(spacing: 20) {
                    HStack(spacing: 40) {
                        WeatherDetail(icon: "humidity", value: "\(humidity)%", label: "Humidity")
                        WeatherDetail(icon: "wind", value: "\(String(format: "%.1f", windSpeed)) mph", label: "Wind Speed")
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
    }
}

struct WeatherDetail: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    ContentView()
}
