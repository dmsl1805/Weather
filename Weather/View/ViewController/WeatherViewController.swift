//
//  ViewController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/10/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, ViewControllerProtocol {

    @IBOutlet var weatherDetailVcTopConstraint: NSLayoutConstraint!
    
    var selectCityVc: SelectItemViewController!
    var forecastDetailVc: ForecastDetailViewController!
    var containerVc: ContainerViewController!
    var presenter: ViewControllerPresenterProtocol!
    
    let loaderVc = EmptyLoaderViewController()
    let graphVc = GraphViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectVC = segue.destination as? SelectItemViewController {
            selectCityVc = selectVC
        } else if let container = segue.destination as? ContainerViewController {
            containerVc = container
            container.currentViewController = loaderVc
        } else if let forecastDetail = segue.destination as? ForecastDetailViewController {
            forecastDetailVc = forecastDetail
        }
    }
}

