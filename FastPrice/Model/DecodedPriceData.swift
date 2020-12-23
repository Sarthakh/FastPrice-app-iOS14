//
//  DecodedPriceData.swift
//  FastPrice
//
//  Created by Sarthak Khillan on 16/12/20.
//

import Foundation

struct DecodedPriceData: Decodable {
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
