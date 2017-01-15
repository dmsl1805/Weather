//
//  GraphViewControllerPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/12/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class GraphViewControllerPresenter: NSObject, ViewControllerPresenterProtocol {
    
    var model: ModelProtocol? {
        didSet {
            updateGraph()
        }
    }
    
    var forecastModel: [Forecast]? {
        get {
            return model as? [Forecast]
        }
        set {
            model = newValue
        }
    }
    
    unowned var viewController: UIViewController
    var graphVC: GraphViewController {
        get {
            return viewController as! GraphViewController
        }
        set {
            viewController = newValue
        }
    }
    
    required init( viewController: UIViewController, model: ModelProtocol?) {
        self.viewController = viewController as! GraphViewController
        self.model = model as! [Forecast]
    }
    
    func configure() {
        
        graphVC.graphView?.dataPointLabelFont = UIFont.systemFont(ofSize: 16)
        graphVC.graphView?.referenceLineLabelFont = UIFont.systemFont(ofSize: 16)
        graphVC.graphView?.shouldAutomaticallyDetectRange = false
        graphVC.graphView?.shouldAdaptRange = false
        graphVC.graphView.indicatorStyle = .white
        
        updateGraph()
    }
    
    func updateGraph() {
        func update() {
            var data = [Double]()
            var labels = [String]()
            
            self.forecastModel?.forEach { forecast in
                data.append(Double(forecast.temp))
                let format = DateFormatter()
                format.dateFormat = "MM.dd HH:mm"
                let label = format.string(from: forecast.date! as Date)
                labels.append(label)
            }
            
            self.graphVC.graphView.rangeMin = data.min() ?? 0
            self.graphVC.graphView.rangeMax = data.max() ?? 10
            self.graphVC.graphView.set(data: data, withLabels: labels)
        }
        if ( !Thread.isMainThread ) {
            OperationQueue.main.addOperation { update() }
        } else {
            update()
        }
    }

    func viewWillLayoutSubviews() {
        
    }
}
