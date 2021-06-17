//
//  ContentView.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculatorTab()
                .tabItem {
                    Image(systemName: "x.squareroot")
                    Text("Rechner")
                }
                .tag(1)
            LocationTab()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Karte")
                }
                .tag(2)
            DestinationTab()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Ziele")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ContentView().preferredColorScheme)
    }
}
