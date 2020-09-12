//
//  weatherManager.swift
//  Clima
//
//  Created by 3bdo on 6/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//


import UIKit
import CoreLocation

class WeatherViewController: UIViewController , WeatherManagerDelegate{

    var weatherMange = weatherManager()
    let locationManager = CLLocationManager()
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTxtField.delegate = self
        weatherMange.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func searchButton(_ sender: Any) {
        cityTxtField.endEditing(true)
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if cityTxtField.text == "" {
            cityTxtField.placeholder = "Please Enter City"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityTxtField.text {
        weatherMange.fetchWeather(city: city)
        }
        cityTxtField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTxtField.endEditing(true)
        return true
    }
    
    func didUpdateWeather(_ weatherManager: weatherManager, weather: WeatherModel) {
        
    }
    
    func didFailWithError(_ error: Error){
        print(error)
    }
    
}

//MARK: - LocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherMange.fetchWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

