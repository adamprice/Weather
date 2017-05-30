//
//  ForecastReporting.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation

protocol ForecastReporting: class {
    
    func forecastRetriever(_ forecastRetriever: ForecastRetriever, didRetrieveForecast forecast: Forecast)
    func forecastRetrieverDidFailToRetrieveForecast(_ forecastRetriever: ForecastRetriever)
    
}
