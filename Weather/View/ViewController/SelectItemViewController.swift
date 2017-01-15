//
//  SelectItemViewController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class SelectItemViewController: UIViewController, ViewControllerProtocol {

    @IBOutlet var itemViews: [CenterItemView]!
    
    var presenter: ViewControllerPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configure()
        itemViews.forEach { view in
            view.presenter?.configure()
        }
    }
}
