//
//  CityViewPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class CityViewPresenter: NSObject, ViewPresenterProtocol {
  
    unowned var view: UIView
    var cityView: CenterItemView {
        get {
            return view as! CenterItemView
        }
        set {
            view = newValue
        }
    }
    
    var model: ModelProtocol?
    var cityModel: City? {
        get {
            return model as? City
        }
        set {
            model = newValue
        }
    }
    
    var itemHighlighted: (() -> Void)?
    var itemSelected: ((_ item: City?, _ sender: CityViewPresenter) -> Void)?
    
    required init( view: UIView, model: ModelProtocol?) {
        self.view = view as! CenterItemView
        self.model = model as! City
    }
    
    func layoutSubviews() {
        cityView.label.frame = CGRect(origin: CGPoint.zero, size: cityView.frame.size)
    }
    
    func configure() {
        cityView.label.textAlignment = .center
        cityView.label.text = self.cityModel?.name
        cityView.viewTapped = { [unowned self] sender in
            self.itemSelected?(self.cityModel, self)
        }
    }
    
}
