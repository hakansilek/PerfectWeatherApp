//
//  NetworkManager.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 24.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

class NetworkManager{
    
    static let sharedNetworkManager = NetworkManager()
    private init(){}
    private let scheme = "https"
    private let host = "api.openweathermap.org"
    private let path = "/data/2.5/"
    private let appId = "f8c34df0e2c97c3b2c64d513a75af4d9"
    private let unit = "metric"
    
    func callWeatherAPI(path:String
        , queryParams:[String:String], completion: @escaping (Data?, URLResponse?, Error?)->Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = self.path+path
        var qItems = [URLQueryItem]()
        for (key, value) in queryParams {
            qItems.append(URLQueryItem(name: key, value: value))
        }
        qItems.append(URLQueryItem(name: "appid", value: appId))
        qItems.append(URLQueryItem(name: "units", value: unit))
        urlComponents.queryItems = qItems
        URLSession.shared.dataTask(with:urlComponents.url!) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
