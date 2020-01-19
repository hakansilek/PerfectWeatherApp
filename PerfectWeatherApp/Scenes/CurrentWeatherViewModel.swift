//
//  MainViewModel.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 21.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol{
    
    var delegate: CurrentWeatherViewModelDelegate?
    private let currentWeatherService: CurrentWeatherServiceProtocol
    private let dailyWeatherService: DailyWeatherServiceProtocol
    init(currentWeatherService: CurrentWeatherServiceProtocol, dailyWeatherService: DailyWeatherServiceProtocol) {
        self.currentWeatherService = currentWeatherService
        self.dailyWeatherService = dailyWeatherService
    }
    func loadCurrentWeather(cityName: String = "") {
        self.delegate?.notifyViewController(.setLoading(true))
        currentWeatherService.getCurrentWeather(cityName: cityName) {[weak self] (result) in
            guard let self = self else {return}
            self.delegate?.notifyViewController(.setLoading(false))
            switch result{
            case .success(let response):
                self.delegate?.notifyViewController(.showCurrentWeather(CurrentWeatherPresentation(dto: response.currentWeatherDTO), cityName))
                
            case .error(_):
                self.delegate?.notifyViewController(.errorCurrentWeather)
            }
        }
    }
    func loadDailyWeather(cityName: String = "") {
        dailyWeatherService.getDailyWeather(cityName: cityName) {[weak self](result) in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                self.delegate?.notifyViewController(.showDailyWeather(response.dailyWeatherArr.map({DailyWeatherPresentation(dto: $0)}))) 
            case .error(_):
                self.delegate?.notifyViewController(.errorDailyWeather)
            }
        }
    }
}
