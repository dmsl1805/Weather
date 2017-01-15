//
//  ForecastDetailViewControllerPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/13/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class ForecastDetailViewControllerPresenter: NSObject, ViewControllerPresenterProtocol {
    
    var model: ModelProtocol? {
        didSet {
            configure()
        }
    }
    
    var forecastModel: Forecast? {
        set {
            model = forecastModel
        }
        get {
            return model as? Forecast
        }
    }
    
    unowned var viewController: UIViewController
    unowned var detailVc: ForecastDetailViewController {
        set {
            viewController = detailVc
        }
        get {
            return viewController as! ForecastDetailViewController
        }
    }

    required init( viewController: UIViewController, model: ModelProtocol?) {
        self.model = model
        self.viewController = viewController
    }
    
    func configure() {
        func update() {
            detailVc.rainLabel.text = "\(forecastModel?.rain ?? 0) mm"
            detailVc.windLabel.text = "\(forecastModel?.wind ?? 0) meter/sec"
            detailVc.snowLabel.text = "\(forecastModel?.snow ?? 0) mm"
            detailVc.cloudLabel.text = "\(forecastModel?.clouds ?? 0) %"
        }
        if !Thread.isMainThread {
            OperationQueue.main.addOperation { update() }
        } else {
            update()
        }
    }

    func viewWillLayoutSubviews() {}
}
