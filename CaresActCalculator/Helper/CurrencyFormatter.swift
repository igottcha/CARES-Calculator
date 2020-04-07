//
//  CurrencyFormatter.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/7/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import Foundation

struct Formatter {
    
    static func formatToMoney(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = .current
        return formatter.string(from: NSNumber(value: amount))!
    }
    
}
