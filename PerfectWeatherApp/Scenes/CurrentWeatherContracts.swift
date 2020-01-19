//
//  CurrentWeatherContracts.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 21.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

protocol CurrentWeatherViewModelProtocol {
    var delegate: CurrentWeatherViewModelDelegate?{get}
    func loadCurrentWeather(cityName: String)
    func loadDailyWeather(cityName: String)
}
enum CurrentWeatherViewModelOutput{
    case setLoading(Bool)
    case showCurrentWeather(CurrentWeatherPresentation, String)
    case showDailyWeather([DailyWeatherPresentation])
    case errorCurrentWeather
    case errorDailyWeather
}
protocol CurrentWeatherViewModelDelegate:AnyObject {
    func notifyViewController(_ output: CurrentWeatherViewModelOutput)
}
