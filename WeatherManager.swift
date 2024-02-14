//
//  WeatherManager.swift
//  Clima
//
//  Created by Joel Espinal (JoelEspinal) on 14/9/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=28f83da85012af5dd50e6838ea31d4b1&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
           let wheatherUrl = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: wheatherUrl)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let wheather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(wheather.temperatureString)
            
            return wheather;
        } catch {
          return nil
          
        }
    }
}

