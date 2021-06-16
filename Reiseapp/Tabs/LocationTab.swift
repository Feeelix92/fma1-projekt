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
        NavigationView {
            LazyVGrid(columns: layout, spacing: 10) {
                NavigationLink(
                    destination: MapLocation()) {
                        CalculatorCard(image: "map", title: "Karte")
                }
                .buttonStyle(PlainButtonStyle())
            }.padding(.horizontal)
            .navigationTitle("Ziele")
        }
    }
}

struct LocationTab_Previews: PreviewProvider {
    static var previews: some View {
        LocationTab()
    }
}
