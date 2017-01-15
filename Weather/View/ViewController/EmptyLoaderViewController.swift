//
//  EmptyLoaderViewController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/15/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class EmptyLoaderViewController: UIViewController, ViewControllerProtocol {

    var presenter: ViewControllerPresenterProtocol!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var loaderView: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configure()
    }

}
