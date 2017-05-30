//
//  MockForecastReportingDelegate.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation

class MockForecastReportingDelegate: ForecastReporting {
    
    var didReceiveForecastCalled = false
    
    func forecastRetriever(_ forecastRetriever: ForecastRetriever, didRetrieveForecast forecast: Forecast) {
        didReceiveForecastCalled = true
    }
    
    func forecastRetrieverDidFailToRetrieveForecast(_ forecastRetriever: ForecastRetriever) {
        
    }

}
