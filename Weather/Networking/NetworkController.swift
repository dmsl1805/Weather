//
//  NetworkController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class NetworkController: NSObject, NetworkControllerProtocol {
    
    func executeRequest(_ request: HTTPRequestProtocol,
                        response: @escaping NetworkResponseBlock) -> URLSessionTask {
        
        if let req = request.completeRequest {
            logRequest(request: req)
            let task = URLSession.shared.dataTask(with: req, completionHandler: { [unowned self] (data, urlResponse, error) in
                self.logResponse(request: req, response: urlResponse, error: error)
                if error == nil {
                    if let data = data {
                        do {
                            let jsonValue = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                            response(NetworkResponse(jsonValue), nil)
                        } catch let error {
                            response(nil, error)
                        }
                    }
                } else {
                    response(nil, error)
                }
            })
            task.resume()
            return task
        } else {
            //error
            return URLSessionTask()
        }
    }
    
    func logResponse(request: URLRequest, response: URLResponse?, error: Error?) {
        print("response for: ", request, response ?? error ?? "cannot get any response or error")
    }
    
    func logRequest(request: URLRequest) {
        print("execute request: ", request)
    }
}
