//
//  PerfectWeatherAppTests.swift
//  PerfectWeatherAppTests
//
//  Created by Hakan Silek on 21.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import XCTest
@testable import PerfectWeatherApp
class PerfectWeatherAppTests: XCTestCase {
    
    private var mockView:MockView!
    private var viewModel: CurrentWeatherViewModel!
    private var mockCurrentWeatherService: CurrentWeatherServiceProtocol!
    private var mockDailyWeatherService: DailyWeatherServiceProtocol!
    override func setUp() {
        mockView = MockView()
        mockCurrentWeatherService = MockCurrentWeatherService()
        mockDailyWeatherService = MockDailyWeatherService()
        viewModel = CurrentWeatherViewModel(currentWeatherService: mockCurrentWeatherService, dailyWeatherService: mockDailyWeatherService)
        viewModel.delegate = mockView
    }
    
    func testCurrentWeatherLoad() {
        viewModel.loadCurrentWeather()
        
        XCTAssertEqual(mockView.outputs.count, 3)
    }
    func testDailiyWeatherLoad() {
        viewModel.loadDailyWeather()
        
        XCTAssertEqual(mockView.outputs.count, 1)
    }
    
}
private class MockView: CurrentWeatherViewModelDelegate {
    var outputs: [CurrentWeatherViewModelOutput] = []
    func notifyViewController(_ output: CurrentWeatherViewModelOutput) {
        outputs.append(output)
    }
}

private class MockCurrentWeatherService: CurrentWeatherServiceProtocol{
    var path = "currentweather"
    
    func getCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeatherResponse>) -> Void){
        let data = DataLoader.getData(fileName: path)
        let decoder = JSONDecoder()
        let decoded = try! decoder.decode(CurrentWeatherResponse.self, from: data)
        completion(.success(decoded))
    }
}

private class MockDailyWeatherService: DailyWeatherServiceProtocol{
    var path = "dailyweather"
    
    func getDailyWeather(cityName: String, completion: @escaping (Result<DailyWeatherResponse>) -> Void) {
        let data = DataLoader.getData(fileName: path)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let decoded = try! decoder.decode(DailyWeatherResponse.self, from: data)
        completion(.success(decoded))
    }
}
private class DataLoader{
    private init(){}
    static func getData(fileName: String)->Data{
        let bundle = Bundle(for: PerfectWeatherAppTests.self)
        let url = bundle.url(forResource: fileName, withExtension: "json").unsafelyUnwrapped
        let data = try! Data(contentsOf: url)
        return data
    }
}
