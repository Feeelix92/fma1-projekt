//
//  Currency.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

// Display Data
struct CurrencyRate: Identifiable {
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}
