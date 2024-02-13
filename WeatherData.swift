//
//  WeatherData.swift
//  Clima
//
<<<<<<< HEAD
//  Created by Joel Espinal (ClaroDom) on 15/9/23.
=======
//  Created by Joel Espinal (JoelEspinal) on 15/9/23.
>>>>>>> 718c452cf8bcba4f5c734ca28f2f8092548104ff
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather];
}


struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
