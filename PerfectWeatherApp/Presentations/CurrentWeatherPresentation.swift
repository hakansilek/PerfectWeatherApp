//
//  CurrentWeatherPresentation.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 21.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation


struct CurrentWeatherPresentation {
    private let degreeString = "\u{00B0}"
    let iconName:String
    let cityName: String
    let temp: String
    let description:String
    let feelsLike:String
    let humidity:String
    let windSpeed:String
    let visibility: String
    
    init(dto: CurrentWeatherDTO) {
        let idFirstNumber = (dto.weather.first?.id ?? 801)
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "iconmap", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        self.iconName = nsDictionary?.object(forKey: String(idFirstNumber)) as! String
        self.cityName = dto.name
        let splittedDescriprion = dto.weather.first?.description.split(separator: " ") ?? []
        var str = ""
        for item in splittedDescriprion {
            let char = item.first
            var firstChar = char?.uppercased() ?? ""
            let subString = String(item.suffix(item.count-1))
            firstChar.append(subString)
            firstChar.append(" ")
            str.append(firstChar)
        }
        self.description = str
        self.temp = String(format: "%d%@", Int(dto.main.temp), degreeString)
        self.feelsLike = String(format: "%d%@",Int(dto.main.feels_like), degreeString)
        self.humidity = String(format: "%d",Int(dto.main.humidity))
        self.windSpeed = String(format: "%.1f",dto.wind.speed)
        self.visibility = String(format: "%d",Int(dto.visibility))
    }
}
