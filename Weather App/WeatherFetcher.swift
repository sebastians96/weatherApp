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
    var temperatureLow = ""
    var temperatureHigh = ""
    var windSpeed = ""
    var windGust = ""
    var precipProbability = ""
    var pressure = ""
    var icon = ""
    var time = ""
}

class WeatherFetcher {
    
    static func fetchWeather () -> [WeatherData]{
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
                    record.time = "\(Date(timeIntervalSince1970: tmp))"
                    record.icon = day["icon"] as! String
                    record.summary = day["summary"] as! String
                    record.temperatureLow = day["temperatureLow"] as! String
                    record.temperatureHigh = day["temperatureHigh"] as! String
                    record.windSpeed = day["windSpeed"] as! String
                    record.windGust = day["windGust"] as! String
                    record.precipProbability = day["percipProbability"] as! String
                    record.pressure = day["pressure"] as! String
                    forecast.append(record)
                }
            }
            }
        task.resume()
        return forecast
    }
    
}

