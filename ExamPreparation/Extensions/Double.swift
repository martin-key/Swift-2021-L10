//
//  Double.swift
//  ExamPreparation
//
//  Created by Martin Kuvandzhiev on 27.10.21.
//

import Foundation

extension Double {
    var formattedAsCurrency: String {
        if Int(self) / 1000000000000 > 0 {
            return String(format: "$%0.3fT", self/1000000000000)
        }
        
        if Int(self) / 1000000000 > 0 {
            return String(format: "$%0.3fB", self/1000000000)
        }
        
        if Int(self) / 1000000 > 0 {
            return String(format: "$%0.3fM", self/1000000)
        }
        
        return String(format: "$%0.3f", self)
    }
}
