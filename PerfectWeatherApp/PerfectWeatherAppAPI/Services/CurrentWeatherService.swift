//
//  CurrentWeatherService.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 18.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

protocol CurrentWeatherServiceProtocol {
    var path: String{get}
    func getCurrentWeather(cityName:String, completion: @escaping (Result<CurrentWeatherResponse>)->Void)
}

final public class CurrentWeatherService: CurrentWeatherServiceProtocol{
    let path = "weather"
    func getCurrentWeather(cityName:String, completion: @escaping (Result<CurrentWeatherResponse>)->Void){
        let queryParams = ["q":cityName]
        NetworkManager.sharedNetworkManager.callWeatherAPI(path:path ,queryParams: queryParams) { (data, response, error) in
           if let error = error{
                completion(.error(WeatherAppError.networkError(error)))
            } else{
                guard let data = data else {
                    return
                }
                let decoder = JSONDecoder()
                do{
                   let response = try decoder.decode(CurrentWeatherResponse.self, from: data)
                    completion(.success(response))
                }catch{
                    completion(.error(WeatherAppError.jsonParseError(error)))
                }
            }
        }
    }
}


