//
//  DailyWeatherPresentation.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 28.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

struct DailyWeatherPresentation{
    private let degreeString = "\u{00B0}"
    let time: String
    let date: String
    let iconName: String
    let temp: String
    init(dto: DailyWeatherDTO) {
        let idFirstNumber = (dto.weather.first?.id ?? 801)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        self.date = dateFormatter.string(from: dto.dt_txt)
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "iconmap", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        self.iconName = nsDictionary?.object(forKey: String(idFirstNumber)) as! String
        self.temp = String(format: "%d%@", Int(dto.main.temp), degreeString)
        
        dateFormatter.dateFormat = "HH:mm"
        self.time = dateFormatter.string(from: dto.dt_txt)
    }
}
