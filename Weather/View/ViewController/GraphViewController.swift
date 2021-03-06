//
//  GraphViewController.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/12/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import ScrollableGraphView

class GraphViewController: UIViewController, ViewControllerProtocol {
    
    var graphView: ScrollableGraphView! {
        return view as! ScrollableGraphView
    }
    
    var presenter: ViewControllerPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configure()
    }

}
