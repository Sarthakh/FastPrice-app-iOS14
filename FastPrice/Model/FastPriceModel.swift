//
//  FastPriceModel.swift
//  FastPrice
//
//  Created by Sarthak Khillan on 16/12/20.
//

import Foundation

struct FastPriceModel{
    var rawRate: Double?
    
    var rate: String?{
        if let doubleRate = rawRate{
            return String(format: "%.1f", doubleRate)
        }
        return nil
    }
}
