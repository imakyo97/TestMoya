//
//  WeatherData.swift
//  TestMoya
//
//  Created by 今村京平 on 2022/02/26.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
}
