//
//  City.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/10/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class City: NSObject, ModelProtocol {
    let id: Int
    let name: String
    let country: String
    
    init(id: Int, name: String, country: String) {
        self.id = id
        self.name = name
        self.country = country
    }
}
