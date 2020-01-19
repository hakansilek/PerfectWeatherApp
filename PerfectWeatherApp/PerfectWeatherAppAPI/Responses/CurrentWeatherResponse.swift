//
//  CurrentWeatherResponse.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 18.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation
final public class CurrentWeatherResponse: Decodable{
    let currentWeatherDTO: CurrentWeatherDTO
    public init(from decoder: Decoder)throws {
        let root = try decoder.singleValueContainer()
        self.currentWeatherDTO = try root.decode(CurrentWeatherDTO.self)
    }
}
