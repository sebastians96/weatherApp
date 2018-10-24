//
//  ViewController.swift
//  Weather App
//
//  Created by Iza on 24.10.2018.
//  Copyright © 2018 Sebastian S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var date: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let forecast = WeatherFetcher.fetchWeather()
        print("Hello World!")
//        DispatchQueue.main.sync(execute: {
//
//
//            self.date.text = forecast[0]?.time
//
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

