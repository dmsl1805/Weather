//
//  ForecastDetailViewController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/13/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class ForecastDetailViewController: UIViewController, ViewControllerProtocol {

    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var rainLabel: UILabel!
    @IBOutlet var snowLabel: UILabel!
    
    
    var presenter: ViewControllerPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configure()
    }

}
