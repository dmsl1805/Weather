//
//  WeatherViewControllerPresenter.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class WeatherViewControllerPresenter: NSObject, ViewControllerPresenterProtocol, SpiderDelegateProtocol {
    
    unowned var viewController: UIViewController
    var weatherVC: WeatherViewController {
        get {
            return viewController as! WeatherViewController
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
    
    var spider: Spider<Forecast>?
    let persistentStorageController = PersistentStorageController(modelName: "WeatherModel")
    let networkController = NetworkController()
    var forecastUpdateHTTPRequest: ForecastUpdateHTTPRequest! {
        didSet {
            spider?.request = forecastUpdateHTTPRequest
        }
    }
    
    required init( viewController: UIViewController, model: ModelProtocol?) {
        self.model = model
        self.viewController = viewController

        super.init()
        
        self.forecastUpdateHTTPRequest = ForecastUpdateHTTPRequest(model: self.cityModel!.first!)
        
        self.spider = Spider<Forecast>(persistentStorageController,
                                       networkController: networkController,
                                       request: forecastUpdateHTTPRequest)
        self.spider?.delegate = self
        
    }
    
    func viewWillLayoutSubviews() { }
    
    func configure() {
        let allData = self.persistentStorageController.fetchAllForecast()
        allData.forEach({ forecast in
            print(forecast.city_id, forecast.weather_descr ?? "weather_descr error")
        })
        print(allData.count)
        
        let selectItemPresenter = SelectItemViewControllerPresenter(viewController: weatherVC.selectCityVc!, model: cityModel)
        selectItemPresenter.selctedCityId = Int(allData.first?.city_id ?? -1024)
        var previousSelectedView: UIView?
        selectItemPresenter.itemSelected = { [unowned self] (city: City?, sender: CityViewPresenter) -> Void in
            self.forecastUpdateHTTPRequest.city = city!
            self.spider?.sendRequest().deleteInfo().writeInfo().execute()
            if previousSelectedView != sender.cityView {
                (previousSelectedView as? CenterItemView)?.isSelected = false
                previousSelectedView = sender.cityView
            }
        }
        
        weatherVC.selectCityVc!.presenter = selectItemPresenter
        
        let graphPresenter = GraphViewControllerPresenter(viewController: weatherVC.forecastVc!, model: allData)
        weatherVC.forecastVc?.presenter = graphPresenter
        
        let forecastDetailPresenter = ForecastDetailViewControllerPresenter(viewController: weatherVC.forecastDetailVc!, model: allData.first)
        weatherVC.forecastDetailVc.presenter = forecastDetailPresenter
    }
    
    // MARK: SpiderDelegateProtocol
    
    func spider(_ spider: SpiderProtocol,
                         didGet response: TempObjectStorageProtocol?,
                         error: Error?) {
        
    }
    
    func spider(_ spider: SpiderProtocol, didFinishExecuting operation: SpiderOperationType) {
        switch operation {
        case .writeInfo:
            OperationQueue.main.addOperation {
                let allForecast = self.persistentStorageController.fetchAllForecast()
                self.weatherVC.forecastVc?.presenter?.model = allForecast
                self.weatherVC.forecastDetailVc.presenter.model = allForecast.first
            }
        default:
            break
        }
    }
    

}
