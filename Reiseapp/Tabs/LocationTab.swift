//
//  LocationTab.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct LocationTab: View {
    var layout = [GridItem(.flexible())]
    var body: some View {
        MapLocation()
    }
}

struct LocationTab_Previews: PreviewProvider {
    static var previews: some View {
        LocationTab()
    }
}
