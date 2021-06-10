//
//  ConversionConvert.swift
//  Reiseapp
//
//  Created by FMA1 on 09.06.21.
//

import SwiftUI

// Fetch Data
struct ConversionConvert: Decodable {
    var info: [String: Double]
    var date: String
    var result: Double
}
