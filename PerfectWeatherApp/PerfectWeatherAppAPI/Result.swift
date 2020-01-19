//
//  Result.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 18.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import Foundation

public enum Result<Value>{
    case success(Value)
    case error(Error)
}
