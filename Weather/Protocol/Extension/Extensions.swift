//
//  Extensions.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import CoreData
import UIKit

extension Forecast: EntityProtocol {
    @objc public static var entityName: String {
        let req: NSFetchRequest<Forecast> = Forecast.fetchRequest()
        return req.entityName ?? "Forecast"
    }
}

extension NSManagedObject: ModelProtocol { }

extension PersistentStorageController: PersistentStorageControllerProtocol {
    
    // MARK: PersistentStorageControllerProtocol
    
    func update(name: String, with objects: TempObjectStorageProtocol) {
        switch name {
        case Forecast.entityName:
            let objects = objects as! NetworkResponse
            let list = objects.objects["list"] as! Array<Dictionary<String, Any>>
            list.forEach({ forecast in
                let entity = insertEntity(name) as! Forecast
                let dateTxt = forecast["dt_txt"] as! String
                let format = DateFormatter()
                format.dateFormat = "yyyy-mm-dd HH:mm:ss"
                let date = format.date(from: dateTxt)
                entity.date = date as NSDate?
                
                let city = objects.objects["city"] as! Dictionary<String, Any>
                let cityId = city["id"] as! Int32
                entity.city_id = cityId
                
                if let clouds = (forecast["clouds"] as? Dictionary<String, Any>)?["all"] as? Int16 {
                    entity.clouds = clouds
                }
                if let rain = (forecast["rain"] as? Dictionary<String, Any>)?["3h"] as? Float {
                    entity.rain = rain
                }
                if let snow = (forecast["snow"] as? Dictionary<String, Any>)?["3h"] as? Float {
                    entity.snow = snow
                }
                if let temp = (forecast["main"] as? Dictionary<String, Any>)?["temp"] as? Float {
                    entity.temp = temp
                }
                if let wind = (forecast["wind"] as? Dictionary<String, Any>)?["speed"] as? Float {
                    entity.wind = wind
                }
                let weather = ((forecast["weather"] as? Array<Any>)?.first as? Dictionary<String, Any>)?["description"] as? String
                entity.weather_descr = weather
            })
            
            break
        default:
            print("Probably not valid entity name")
            break
        }
        
        save()
    }
    
    func remove(name: String, new objects: TempObjectStorageProtocol) {
        fetch(entityNamed: name)?.forEach({[unowned self] entity in
            let objectInBg = self.contextStore.background.object(with: (entity as! NSManagedObject).objectID)
            self.contextStore.background.delete(objectInBg)
        })
        
        save()
    }
    
    //MARK: Custom helpers
    
    func insertEntity(_ name: String) -> EntityProtocol {
        return NSEntityDescription.insertNewObject(forEntityName: name,
                                                   into: self.contextStore.background) as! EntityProtocol
    }
    
    func fetchAllForecast() -> [Forecast] {
        let sortDescr = NSSortDescriptor(key: "date",
                                         ascending: true)
        return fetch(entityNamed: Forecast.entityName,
                     andSort: [sortDescr]) as! [Forecast]
    }
    
    func fetch(entityNamed name: String,
               withPredicate predicate: NSPredicate? = nil,
               andSort sortDescriptors: [NSSortDescriptor]? = nil) -> [EntityProtocol]? {
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = NSEntityDescription.entity(forEntityName: name, in: self.contextStore.main)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            let results = try self.contextStore.main.fetch(request)
            return (results as! [EntityProtocol])
        } catch let error {
            print("error while fetching with predicate \(predicate), from persistent store, error: \(error)")
            return nil
        }
    }
}
