//
//  DailyWeatherResponse.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 27.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation
final public class DailyWeatherResponse: Decodable{
    let dailyWeatherArr: [DailyWeatherDTO]
    public init(from decoder: Decoder)throws{
        let root = try decoder.container(keyedBy: DailyWeatherList.self)
        dailyWeatherArr = try root.decode([DailyWeatherDTO].self, forKey: .list)
    }
    
    private enum DailyWeatherList: CodingKey{
        case list
    }
}
