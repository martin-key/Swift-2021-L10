//
//  Coin.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import Foundation
import RealmSwift


class Coin: Object {
    @Persisted var id: String = ""
    @Persisted var symbol: String = ""
    @Persisted var name: String = ""
    @Persisted var image: String = ""
    @Persisted var current_price: Double = 0
    @Persisted var market_cap: Double = 0
    @Persisted var market_cap_rank: Int = 0
    @Persisted var total_volume: Double = 0
    @Persisted var high_24h: Double = 0
    @Persisted var low_24h: Double = 0
    @Persisted var price_change_24h: Double = 0
    @Persisted var price_change_percentage_24h: Double = 0
    @Persisted var circulating_supply: Double = 0
    @Persisted var total_supply: Double? = 0
    @Persisted var last_updated: String = ""
    
    static override func primaryKey() -> String? {
        return "id"
    }
}

