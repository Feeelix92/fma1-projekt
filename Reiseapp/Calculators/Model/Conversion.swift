//
//  Conversion.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

// Fetch Data
struct Conversion: Decodable {
    var rates : [String: Double]
    var date: String
    var base: String
}
