//
//  AppDelegate.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 18.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CurrentWeatherViewController()
        let vm = CurrentWeatherViewModel(currentWeatherService: CurrentWeatherService(), dailyWeatherService: DailyWeatherService())
        vc.viewModel = vm
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }


}

