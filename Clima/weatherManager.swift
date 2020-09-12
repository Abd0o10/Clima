//
//  weatherManager.swift
//  Clima
//
//  Created by 3bdo on 6/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: weatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct weatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=a267c7575c7c331348f175a7ef5985eb&units=metric"
    func fetchWeather (city: String) {
        let URLString = "\(weatherURL)&q=\(city)"
        performRequest(with: URLString)
    }
    
    func fetchWeather(lat: Double, lon: Double){
        let URLString = "\(weatherURL)&lat=\(lat)&lon\(lon)"
        performRequest(with: URLString)
    }
    
    func performRequest(with urlString: String) {
        
            // 1- Making URL
        if let url = URL(string: urlString) {
            
            // 2- URLsession
            let session = URLSession(configuration: .default)
            
            // 3- Give a task For this session
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.paraseJSON(data: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            )
            // 4- Start the task
            task.resume()
        }
    }
    
    func paraseJSON(data: Data) -> WeatherModel? {
        let jsonDecoder = JSONDecoder()
        do {
            let dataDecoded = try jsonDecoder.decode(weatherData.self, from: data)
            
            let id = dataDecoded.id
            let name = dataDecoded.name
            let temp = dataDecoded.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
