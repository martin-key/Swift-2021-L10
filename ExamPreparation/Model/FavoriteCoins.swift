//
//  FavoriteCoins.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @Persisted var userId: String = "123"
    @Persisted var favoriteCoins: List<String> = List<String>()
    
    static override func primaryKey() -> String? {
        return "userId"
    }
}
