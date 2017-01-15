//
//  ForecastUpdateHTTPRequest.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class ForecastUpdateHTTPRequest: NSObject, HTTPRequestProtocol {
    
    var completeRequest: URLRequest {
        let url = URL(string: openweatherForecastApiDomain.appending("?id=\(city.id)&APPID=\(openweatherAPPID)&units=metric"))!
        let req = URLRequest(url: url)
        return req
    }
    
    var city: City
    
    init(model: City) {
        self.city = model
    }

}
