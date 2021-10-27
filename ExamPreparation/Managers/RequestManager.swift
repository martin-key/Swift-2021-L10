//
//  RequestManager.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import Foundation
import Alamofire


struct API {
    static let marketsURL = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
}

enum RequestManagerError: Error {
    case cannotParseData
}

class RequestManager {
    class func fetchAllMarketData(completion: @escaping ((_ error: Error?) -> Void)) {
        let params: [String: String] = [
            "vs_currency": "usd",
            "order": "market_cap_desc",
            "per_page": "100",
            
        ]
        AF.request(API.marketsURL,
                   method: .get,
                   parameters: params)
            .responseJSON { response in
                guard response.error == nil else {
                    completion(response.error)
                    return
                }
                
                guard let coinsJSON = response.value as? [[String: Any]] else {
                    completion(RequestManagerError.cannotParseData)
                    return
                }
                
                let coins = coinsJSON.map({ Coin(value: $0) })
                
                DispatchQueue.main.async {
                    try? LocalDataManager.realm.write {
                        LocalDataManager.realm.add(coins, update: .all)
                    }
                    
                    NotificationCenter.default.post(name: .marketDataLoaded, object: nil)
                    completion(nil)
                }
            }
    }
}
