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
    var forecastVc: GraphViewController!
    var forecastDetailVc: ForecastDetailViewController!
    var presenter: ViewControllerPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectVC = segue.destination as? SelectItemViewController {
            selectCityVc = selectVC
        } else if let forecast = segue.destination as? GraphViewController {
            forecastVc = forecast
        } else if let forecastDetail = segue.destination as? ForecastDetailViewController {
            forecastDetailVc = forecastDetail
        }
    }

    func showEntryView() {
        //
    }
}

