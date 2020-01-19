//
//  CurrentWeatherDTO.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 18.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

struct CurrentWeatherDTO:Decodable {
    let weather:[Weather]
    let main:Main
    let wind: Wind
    let clouds:Cloud
    let name:String
    let visibility: Float
}
struct Weather:Decodable {
    let id:Int
    let main: String
    let description:String
    let icon: String
}
struct Main:Decodable {
    let temp:Float
    let feels_like:Float
    let temp_min:Float
    let temp_max:Float
    let pressure:Float
    let humidity:Float
}
struct Wind:Decodable {
    let speed: Float
}
struct Cloud:Decodable {
    let all:Float
}




