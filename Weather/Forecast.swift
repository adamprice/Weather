//
//  Forecast.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Forecast {
    
    let forecastDays = 5
    
    var currentWeather: WeatherWindow?
    var futureWeather: [WeatherWindow]?
    
    let dateFormatter: DateFormatter
    
    var today: [WeatherWindow]? {
        return weather(daysFromNow: 0)
    }
    
    var tomorrow: [WeatherWindow]? {
        return weather(daysFromNow: 1)
    }
    
    init(forecastData: JSON) {
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        if let forecastList = forecastData["list"].array {
            
            var weather: [WeatherWindow] = []
            
            for weatherWindow in forecastList {
                
                if let temperature = weatherWindow["main"]["temp"].double, let code = weatherWindow["weather"][0]["id"].int, let timestamp = weatherWindow["dt"].int, let description = weatherWindow["weather"][0]["description"].string {
                    
                    let date = Date(timeIntervalSince1970: Double(timestamp))
                    let window = WeatherWindow(temperature: temperature, code: code, time: date, description: description)
                    weather.append(window)
                }
                
            }
            
            currentWeather = weather.removeFirst()
            futureWeather = weather
        }
        
    }
    
}

// MARK: - Helper functions

extension Forecast {
    
    func weather(daysFromNow days: Int) -> [WeatherWindow]? {
        
        guard let date = Calendar.current.date(byAdding: .day, value: days, to: Date()) else {
            return nil
        }
        
        return futureWeather?.filter {
            Calendar.current.isDate($0.time, inSameDayAs: date)
        }
        
    }
    
    func dayNamesForForecast() -> [String] {
        
        var days = [String]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        if let weatherWindow = futureWeather?.first {
            
            for index in 0...forecastDays {
                let day = Calendar.current.date(byAdding: .day, value: index, to: weatherWindow.time)
                days.append(dateFormatter.string(from: day!))
            }
            
        }
        
        return days
        
    }
    
}
