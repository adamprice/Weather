//
//  ForecastRetrieverTests.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Mockingjay

class ForecastRetrieverSpec: QuickSpec {
    
    override func spec() {
        
        let mockDelegate = MockForecastReportingDelegate()
        
        let path = Bundle(for: type(of: self)).path(forResource: "forecast", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        
        let config = Configuration(apiProtocol: "http", hostname: "api.openweathermap.org", apiKey: "a67415ead65932caa5daf98f9f893104", units: "imperial")
        
        var forecastRetriever: ForecastRetriever?
        
        stub(everything, jsonData(data as Data))
        
        describe("The forecast retriever") {
            
            beforeEach {
                forecastRetriever = ForecastRetriever(configuration: config, delegate: mockDelegate)
                forecastRetriever?.update()
            }
            
            it("uses the configuration passed into the constructor") {
                
            }
            
            context("if the API is accessible") {
                
                it("retrieves the forecast") {
                    
                }
                
                it("passes the forecast to the delegate") {
                    expect(mockDelegate.didReceiveForecastCalled).toEventually(beTrue(), timeout: 5.5, pollInterval: 0.2)
                }
                
            }
            
            context("if it can't access the API") {
                
                it("throws an appropriate error") {
                    
                }
                
            }
            
        }
        
    }
    
}
