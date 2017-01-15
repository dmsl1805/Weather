//
//  SpiderProtocols.swift
//
//  Created by Dmitriy Shulzhenko on 11/27/16.
//  Copyright © 2016 Dmitriy Shulzhenko. All rights reserved.
//

import Foundation

@objc public enum SpiderOperationType: Int {
    case getInfo
    //case postInfo
    case writeInfo
    case deleteInfo
    //case deleteData
    case downloadData
    //    case writeData
}
// Storage that will be used to update model

@objc public protocol TempObjectStorageProtocol: class{} //ObjectWithPrimaryKeyProtocol { }


// Entity object. Can be subclass of NSManagedObject, or smth else

@objc public protocol EntityProtocol {
    
    @objc static var entityName: String { get }
        
    // Entity that contains some data (NSData, Image, ets.)
        
    @objc optional var dataRemoutePaths: [String] { get }
    
    @objc optional var dataNames: [String] { get }
    
}

// Model for HTTP request.
// forMethod parameter is used because your request can be different if you want to make local or remoute updates

@objc public protocol HTTPRequestProtocol {
    
    @objc optional var httpMethod: String { get }
    
    @objc optional var requestURL: String { get }
    
    @objc optional var urlParameters: Any { get }
    
    @objc optional var bodyParameters: Any { get }
    
    @objc optional var completeRequest: URLRequest { get }
    
}

@objc public protocol PersistentStorageControllerProtocol {
    
    @objc optional func update(name: String, with objects: TempObjectStorageProtocol)
    
    @objc optional func remove(name: String, new objects: TempObjectStorageProtocol)
    
    @objc optional func fetchWithoutData(name: String) -> [EntityProtocol]?

    @objc optional func write(data dataStore: [TempObjectStorageProtocol], completed:((_ error: Error?) -> Void))
    
    //    @objc func delete(data named: String, completed:((_ error: Error?) -> Void))
    
    @objc optional func get(data named: String) -> Data?
    
//
//    @objc optional var entitiesCount: Int { get }
//    
//    @objc optional func entity(atIndex index: Int) -> EntityProtocol
//    
//    @objc optional func index(of entity: EntityProtocol) -> NSNumber?
//    
//    @objc optional func undo()
//    
//    @objc optional func redo()
//    
//

    //

//    
//    @objc optional func fetch(withName name: String) -> EntityProtocol
//    
//    @objc optional func fetch(withPredicate predicate: NSPredicate?,
//                              name: String) -> [EntityProtocol]?
//    
    
}


// MARK: Network manager

public typealias NetworkResponseBlock = (_ objects: TempObjectStorageProtocol? , _ error: Error? ) -> (Void)
//public typealias NetworkDataResponseBlock = (_ dataStore: TempObjectStorageProtocol? , _ error: Error? ) -> (Void)

@objc public protocol NetworkControllerProtocol {
    
    @objc func executeRequest(_ request: HTTPRequestProtocol,
                              response: @escaping NetworkResponseBlock) -> URLSessionTask
    
//    @objc optional func download(from: String,
//                                 response: NetworkDataResponseBlock) -> URLSessionTask
//    
}


// MARK: Model updater

//protocol PersistantModelUpdaterManagerProtocol {
//    func updatePersistent()
//    var networkManager: NetworkManagerDataProtocol { get set }
//    var persistentContext: EntityWithDataFetcherProtocol { get set }
//    var persistentDataManager: DataManagerProtocol { get set }
//}
//
//protocol TemporaryModelUpdaterManagerProtocol {
//    func updateTemporary()
//    var networkManager: NetworkManagerDataProtocol { get set }
//    var tempContext: EntityWithDataFetcherProtocol { get set }
//    var tempDataManager: DataManagerProtocol { get set }
//}

//protocol PersistentDataModelUpdaterManagerProtocol: PersistantModelUpdaterManagerProtocol {
//    
//    associatedtype P: PersistentEntityDataProtocol
//    associatedtype T: TemporaryEntityProtocol
//    var persistentUpdater: DataModelUpdater<P, T> { get set }
//}

//protocol TemporaryDataModelUpdaterManagerProtocol: TemporaryModelUpdaterManagerProtocol {
//    
//    associatedtype P: PersistentEntityDataProtocol
//    associatedtype T: TemporaryEntityProtocol
//    var tempUpdater: DataModelUpdater<P, T> { get set }
//}


@objc public protocol SpiderProtocol { }

@objc public protocol SpiderDelegateProtocol {
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                didExecute task: URLSessionTask)
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                didGet response: TempObjectStorageProtocol?,
                                error: Error?)
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                didFinishExecuting operation: SpiderOperationType)
    
    @objc optional func spider(_ spider: SpiderProtocol,
                               didDownload dataStore: TempObjectStorageProtocol?,
                               forEntity: EntityProtocol,
                               error: Error?)
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                willWrite dataStore: TempObjectStorageProtocol,
                                forEntity: EntityProtocol)
    
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                queuePiority forEntity: EntityProtocol,
                                dataPath: String) -> Operation.QueuePriority
    
    @objc optional func spider(_ spider: SpiderProtocol,
                                qualityOfService: EntityProtocol,
                                dataPath: String) -> QualityOfService

    @objc optional func spider(_ spider: SpiderProtocol,
                               shouldTerminate operation: SpiderOperationType) -> Bool
}

//@objc protocol ModelUpdaterDataDelegate: ModelUpdaterDelegate {

//    // TODO: todo
//    @objc optional func updater(_ updater: ModelUpdaterProtocol,
//                 didWrite data: Data,
//                 forEntity: PersistentEntityDataProtocol,
//                 error: Error?)
//    @objc optional func updater(_ updater: ModelUpdaterProtocol,
//                 willDelete data: Data,
//                 forEntity: PersistentEntityDataProtocol)
//    @objc optional func updater(_ updater: ModelUpdaterProtocol,
//                 queuePiority forEntity: PersistentEntityProtocol) -> Operation.QueuePriority
//    @objc optional func updater(_ updater: ModelUpdaterProtocol,
//                 qualityOfService: PersistentEntityProtocol) -> QualityOfService
//}

@objc public protocol SpiderOperationProtocol {
    var objectStorage: TempObjectStorageProtocol? { get set }
    var dependents: [SpiderOperationProtocol]? { get set }
    func finish()
}

