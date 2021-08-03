//
//  CoinModel.swift
//  coinAppIOS
//
//  Created by chekir walid on 3/8/2021.
//

import Foundation

struct CoinModel {
    let quote: String
    let rate: Double
    
    var quoteString: String{
        return String(format: "%.2f", quote)
    }
}
