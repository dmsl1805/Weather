//
//  NetworkResponse.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import Foundation

class NetworkResponse: NSObject, TempObjectStorageProtocol {
    var objects: Dictionary<String, Any>
    init(_ objects: Dictionary<String, Any>) {
        self.objects = objects
    }
}
