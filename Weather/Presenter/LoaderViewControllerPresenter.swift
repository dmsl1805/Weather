//
//  LoaderViewControllerPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/15/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

extension String: ModelProtocol {}

class LoaderViewControllerPresenter: NSObject, ViewControllerPresenterProtocol {
    unowned var viewController: UIViewController
    var loaderVc: EmptyLoaderViewController {
        set {
            viewController = newValue
        }
        get {
            return viewController as! EmptyLoaderViewController
        }
    }
    
    var model: ModelProtocol? {
        didSet {
            loaderVc.label.text = labelText
        }
    }
    
    var labelText: String {
        set {
            model = newValue
        }
        get {
            return model as! String
        }
    }
    
    var loaderHidden: Bool = false {
        didSet {
            if loaderHidden {
                loaderVc.loaderView.stopAnimating()
            } else {
                loaderVc.loaderView.startAnimating()
            }
        }
    }
    
    required init( viewController: UIViewController, model: ModelProtocol?) {
        self.viewController = viewController as! EmptyLoaderViewController
        self.model = model as! String
    }
    
    func configure() {
        loaderVc.label.text = labelText
        if loaderHidden {
            loaderVc.loaderView.stopAnimating()
        } else {
            loaderVc.loaderView.startAnimating()
        }
    }

    func viewWillLayoutSubviews() {}
}
