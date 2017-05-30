//
//  ForecastTests.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Mockingjay

class ForecastSpec: QuickSpec {
    
    override func spec() {
        
        describe("The forecast object") {
            
            context("if it's initialised with valid forecast data") {
                
                it("parses the forecast data correctly") {
                
                }
                
                it("provides the current forecast") {
                    
                }
                
                it("provides the forecast for the next 5 days in 3 hour windows") {
                    
                }
                
            }
            
            context("if it's initialised with invalid forecast data") {
                
                it("throws an appropriate error") {
                    
                }
                
            }
            
        }
        
    }
    
}
