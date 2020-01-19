//
//  DailyWeatherDTO.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 27.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

struct DailyWeatherDTO: Decodable {
    let main: Main
    let weather:[Weather]
    let dt_txt: Date
}
