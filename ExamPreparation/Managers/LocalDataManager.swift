//
//  LocalDataManager.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import Foundation
import RealmSwift

class LocalDataManager {
    static let realm = try! Realm(configuration: realmConfiguration, queue: DispatchQueue.main)
    
    static let realmConfiguration: Realm.Configuration = {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = 2
        configuration.deleteRealmIfMigrationNeeded = true
        configuration.migrationBlock = { (migration, version) in
            
        }
        
        return configuration
    }()
    
    static let favorites: Favorites = {
        if let favoriteObject = realm.object(ofType: Favorites.self, forPrimaryKey: "1") {
            return favoriteObject
        }
        
        let favoriteObject = Favorites()
        favoriteObject.userId = "1"
        realm.beginWrite()
        realm.add(favoriteObject, update: .all)
        try? realm.commitWrite()
        return favoriteObject
    }()
}
