//
//  weatherData.swift
//  Clima
//
//  Created by 3bdo on 6/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct weatherData : Codable {
    let id: Int
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
}

struct Weather: Codable {
    let main: String
    let description: String
}
