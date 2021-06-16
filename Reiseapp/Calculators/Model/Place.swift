//
//  Place.swift
//  Reiseapp
//
//  Created by FMA1 on 16.06.21.
//

import SwiftUI
import MapKit

struct Place: Identifiable{
    var id = UUID().uuidString
    var placemark: CLPlacemark
}
