//
//  Protocols.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

protocol ModelProtocol { }

protocol ViewProtocol {
    var presenter: ViewPresenterProtocol! { get set }
}

protocol ViewControllerProtocol {
    var presenter: ViewControllerPresenterProtocol! { get set }
}

protocol PresenterProtocol  {
    var model: ModelProtocol? { get set }
    func configure()
}

protocol ViewPresenterProtocol: PresenterProtocol {
    unowned var view: UIView { get set }
    init( view: UIView, model: ModelProtocol?)
    func layoutSubviews()
}

protocol ViewControllerPresenterProtocol: PresenterProtocol {
    unowned var viewController: UIViewController { get set }
    init( viewController: UIViewController, model: ModelProtocol?)
    func viewWillLayoutSubviews()
}

extension Array: ModelProtocol {}
