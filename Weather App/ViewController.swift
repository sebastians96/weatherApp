//
//  ViewController.swift
//  Weather App
//
//  Created by Iza on 24.10.2018.
//  Copyright © 2018 Sebastian S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var pressure: UITextField!
    @IBOutlet weak var percip: UITextField!
    @IBOutlet weak var maxWind: UITextField!
    @IBOutlet weak var minWind: UITextField!
    @IBOutlet weak var maxTemp: UITextField!
    @IBOutlet weak var minTemp: UITextField!
    @IBOutlet weak var summary: UITextField!
    @IBOutlet weak var icon: UIImageView!
    
    private let weatherFetcher = WeatherFetcher()
    private var counter = 0
    private var forecast: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weatherFetcher.fetchWeather() { [weak self] (data:[WeatherData]) in
            self?.forecast = data
            self?.UpdateController(weather: data)
        }
    }

    func UpdateController(weather: [WeatherData]){
        DispatchQueue.main.async {
            self.date.text = weather[self.counter].time
            self.pressure.text = String(weather[self.counter].pressure)
            self.percip.text = String(weather[self.counter].precipProbability)
            self.minWind.text = String(weather[self.counter].windSpeed)
            self.maxWind.text = String(weather[self.counter].windGust)
            self.maxTemp.text = String(weather[self.counter].temperatureHigh)
            self.minTemp.text = String(weather[self.counter].temperatureLow)
            self.icon.image = UIImage(named: weather[self.counter].icon)
            self.summary.text = weather[self.counter].summary
        }
    }
    
    @IBAction func arrowRight(_ sender: UIButton) {
        if self.counter < 7 {self.counter += 1}
        UpdateController(weather: forecast)
    }
    
    @IBAction func arrowLeft(_ sender: UIButton) {
        if self.counter > 0 {self.counter -= 1}
        UpdateController(weather: forecast)
    }
    
}

