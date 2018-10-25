//
//  WeatherFetcher.swift
//  Weather App
//
//  Created by Iza on 24.10.2018.
//  Copyright © 2018 Sebastian S. All rights reserved.
//

import Foundation

struct WeatherData {
    var summary = ""
    var temperatureLow = 0.0
    var temperatureHigh = 0.0
    var windSpeed = 0.0
    var windGust = 0.0
    var precipProbability = 0.0
    var pressure = 0.0
    var icon = ""
    var time = ""
}

class WeatherFetcher {
    
    func fetchWeather (completion: @escaping ((_ data: [WeatherData])-> Void)){
        var forecast : [WeatherData] = []
        let  apiURL = URL(string: "https://api.darksky.net/forecast/efa3b416123aeaf88d29aa3eaa288db4/50.0646501,19.9449799?exclude=currently,minutely,hourly,flags,alerts")
        let session = URLSession.shared
        let task = session.dataTask(with: apiURL!){ (data, _, error) in
            if let error = error {
                print("Request Did Fail (\(error)")
            }
            else
            {
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let daily = json["daily"] as! [String:Any]
                let data = daily["data"] as! [AnyObject]
                for i in 0...7 {
                    var record: WeatherData = WeatherData()
                    let day = data[i] as! [String: Any]
                    let tmp = day["time"] as! Double
                    record.time = String("\(Date(timeIntervalSince1970: tmp))".prefix(10))
                    record.icon = day["icon"] as! String
                    record.summary = day["summary"] as! String
                    record.temperatureLow = day["temperatureLow"] as! Double
                    record.temperatureHigh = day["temperatureHigh"] as! Double
                    record.windSpeed = day["windSpeed"] as! Double
                    record.windGust = day["windGust"] as! Double
                    if day["percipProbability"] != nil { record.precipProbability = day["percipProbability"] as! Double }
                    record.pressure = day["pressure"] as! Double
                    forecast.append(record)
                }
                completion(forecast)
//                DispatchQueue.main.async {
//                    ViewController().UpdateController(weather: forecast)
//                }
            }
            }
        task.resume()
    }
    
}

