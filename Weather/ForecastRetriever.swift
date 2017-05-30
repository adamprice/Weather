//
//  ForecastRetriever.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ForecastRetriever {
    
    let configuration: Configuration
    let path = "/data/2.5/forecast?"
    let location = "London,UK"
    
    weak var delegate: ForecastReporting?
    
    init(configuration: Configuration, delegate: ForecastReporting) {
        self.configuration = configuration
        self.delegate = delegate
    }
    
    func update() {
        Alamofire.request("\(self.configuration.apiProtocol)://\(self.configuration.hostname)\(path)q=\(location)&units=\(self.configuration.units)&appid=\(self.configuration.apiKey)").responseJSON { response in
            
            if let data = response.result.value {
                let forecast = Forecast(forecastData: JSON(data))
                self.delegate?.forecastRetriever(self, didRetrieveForecast: forecast)
            }
        }
    }
    
}
