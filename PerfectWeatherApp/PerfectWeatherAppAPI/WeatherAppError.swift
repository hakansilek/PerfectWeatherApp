//
//  WeatherAppError.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 27.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

public enum WeatherAppError: Error{
    case jsonParseError(Error)
    case networkError(Error)
}
