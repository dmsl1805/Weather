//
//  SelectItemViewControllerPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class SelectItemViewControllerPresenter: NSObject, ViewControllerPresenterProtocol {
    
    unowned var viewController: UIViewController
    var selectItemVc: SelectItemViewController {
        get {
            return viewController as! SelectItemViewController
        }
        set {
            viewController = newValue
        }
    }
    
    var model: ModelProtocol?
    var cityModel: [City]? {
        get {
            return model as? [City]
        }
        set {
            model = newValue
        }
    }
    
    var itemSelected: ((_ item: City?, _ sender: CityViewPresenter) -> Void)?

    var selctedCityId: Int?
    
    private var cityViewPresenters = Set<CityViewPresenter>()
    
    required init( viewController: UIViewController, model: ModelProtocol?) {
        self.model = model
        self.viewController = viewController
    }
    
    func viewWillLayoutSubviews() { }
    
    func configure() {
        if let seq = self.cityModel?.enumerated() {
            for (index, city) in seq {
                let view = selectItemVc.itemViews[index]
                let presenter = CityViewPresenter(view: view, model: city)
                view.presenter = presenter
                presenter.itemSelected = itemSelected
                view.isSelected = city.id == selctedCityId
                if view.isSelected {
                    itemSelected?(city, presenter)
                }
                cityViewPresenters.insert(presenter)
            }
        }
    }
    
    func didTouch(_ sender: Any) {
        
    }
}
