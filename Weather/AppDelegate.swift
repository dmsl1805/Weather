//
//  AppDelegate.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/10/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let nav = self.window?.rootViewController as! UINavigationController
        let weatherViewController = nav.viewControllers.first as! WeatherViewController
        weatherViewController.presenter = WeatherViewControllerPresenter(viewController: weatherViewController,
                                                                         model: [
                                                                            City(id: 703448, name: "Kiev", country: "UA"),
                                                                            City(id: 524901, name: "Moscow", country: "RU"),
                                                                            City(id: 5056033, name: "London", country: "US"),
                                                                            City(id: 5128581, name: "New York", country: "US")
            ])
        
        return true
    }

}

