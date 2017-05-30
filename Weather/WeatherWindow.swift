//
//  WeatherWindow.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation

struct WeatherWindow {
    
    let temperature: Int
    let code: Int
    let time: Date
    let description: String
    let icon: String
    
    init(temperature: Double, code: Int, time: Date, description: String) {
        self.temperature = Int(temperature)
        self.code = code
        self.time = time
        self.description = description
        
        switch self.code {
            
        case 200...299: // Thunderstorm
            icon = "\u{f01e}"
        case 300...399: // Drizzle
            icon = "\u{f01c}"
        case 500...599: // Rain
            icon = "\u{f019}"
        case 600...699: // Snow
            icon = "\u{f01b}"
        case 700...799: // Atmosphere
            icon = "\u{f014}"
        case 800: // Clear
            icon = "\u{f00d}"
        case 801...899: // Clouds
            icon = "\u{f041}"
        case 900...909: // Extreme
            icon = "\u{f056}"
        case 951...999: // Additional
            icon = "\u{f021}"
        default:
            icon = "\u{f041}"
        }
    }
    
}
