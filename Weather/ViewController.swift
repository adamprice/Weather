//
//  ViewController.swift
//  Weather
//
//  Created by Adam Price on 29/05/2017.
//  Copyright © 2017 Cadno. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
        
    @IBOutlet weak var locationDisplay: UILabel?
    @IBOutlet weak var weatherDisplay: UILabel?
    @IBOutlet weak var temperatureDisplay: UILabel?
    @IBOutlet weak var descriptionDisplay: UILabel?
    @IBOutlet weak var futureWeatherTableView: UITableView?
    @IBOutlet weak var updateSpinner: UIActivityIndicatorView?
    @IBOutlet weak var updateButton: UIButton?
    @IBOutlet weak var tableViewContainer: UIView?
    
    let unit = Locale.current.usesMetricSystem ? "°C" : "°F"
    
    let dateFormatter = DateFormatter()
    var forecastRetriever: ForecastRetriever?
    
    var forecast: Forecast?
    
    var nextFiveDays = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "HH:mm"
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        let units = Locale.current.usesMetricSystem ? "metric" : "imperial"
        let config = Configuration(apiProtocol: "http", hostname: "api.openweathermap.org", apiKey: "a67415ead65932caa5daf98f9f893104", units: units)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)

        
        forecastRetriever = ForecastRetriever(configuration: config, delegate: self)
        updateForecast()
    }
    
    func willEnterForeground() {
        updateForecast()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateForecast() {
        updateButton?.isHidden = true
        updateSpinner?.isHidden = false
        forecastRetriever?.update()
    }

}

// MARK: - UITableViewDelegate protocol conformance

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherHeaderCell") as! WeatherTableHeaderCell
        cell.dayLabel?.text = nextFiveDays[section]
        return cell
    }
    
}

// MARK: - UITableViewDataSource protocol conformance

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nextFiveDays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.weather(daysFromNow: section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTableCell
        
        let sectionData = forecast?.weather(daysFromNow: indexPath.section)
        
        if let window = sectionData?[indexPath.row] {
            cell.timeLabel?.text = dateFormatter.string(from: window.time)
            cell.temperatureLabel?.text = "\(window.temperature)\(unit)"
            cell.weatherLabel?.text = "\(window.icon)"
        }
        
        return cell
    }
    
}

// MARK: - ForecastReporting protocol conformance

extension ViewController: ForecastReporting {

    func forecastRetriever(_ forecastRetriever: ForecastRetriever, didRetrieveForecast forecast: Forecast) {
        self.forecast = forecast
        
        if let currentWeather = forecast.currentWeather {
            weatherDisplay?.text = currentWeather.icon
            temperatureDisplay?.text = "\(currentWeather.temperature)\(unit)"
            descriptionDisplay?.text = currentWeather.description
        }
        
        nextFiveDays = forecast.dayNamesForForecast()
        futureWeatherTableView?.reloadData()
        updateButton?.isHidden = false
        updateSpinner?.isHidden = true
    }
    
    func forecastRetrieverDidFailToRetrieveForecast(_ forecastRetriever: ForecastRetriever) {
        // Show error
    }
}

