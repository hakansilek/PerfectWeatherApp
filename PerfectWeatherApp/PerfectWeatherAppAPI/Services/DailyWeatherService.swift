//
//  DailyWeatherService.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 27.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation
protocol DailyWeatherServiceProtocol {
    var path: String{get}
    func getDailyWeather(cityName:String, completion: @escaping (Result<DailyWeatherResponse>)->Void)
}

final public class DailyWeatherService: DailyWeatherServiceProtocol{
    
    let path = "forecast"
    func getDailyWeather(cityName:String, completion: @escaping (Result<DailyWeatherResponse>)->Void){
        let queryParams = ["q":cityName]
        NetworkManager.sharedNetworkManager.callWeatherAPI(path: path, queryParams: queryParams) { (data, response, error) in
            if let error = error{
                completion(.error(WeatherAppError.networkError(error)))
            } else{
                guard let data = data else {
                    return
                }
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                do{
                    let response = try decoder.decode(DailyWeatherResponse.self, from: data)
                    completion(.success(response))
                }catch{
                    completion(.error(WeatherAppError.jsonParseError(error)))
                }
            }
        }
    }
}
