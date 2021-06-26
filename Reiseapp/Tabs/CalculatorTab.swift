//
//  CalculatorTab.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct CalculatorTab: View {
    var layout = [GridItem(.flexible())]
    var body: some View {
        NavigationView {
            LazyVGrid(columns: layout, spacing: 10) {
                NavigationLink(
                    destination: SpeedCalculator()) {
                    CalculatorCard(image: "speedometer", title: "speed")
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(
                    destination: MeasurementCalculator()) {
                    CalculatorCard(image: "ruler", title: "measurement")
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(
                    destination: TipCalculator()) {
                    CalculatorCard(image: "wallet.pass", title: "tip")
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(
                    destination: CurrencyCalculator()) {
                    CalculatorCard(image: "banknote", title: "currency")
                }
                .buttonStyle(PlainButtonStyle())
                  }
                  .padding(.horizontal)
            .navigationTitle(LocalizedStringKey("calculator"))
        }
    }
}

struct CalculatorTab_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorTab()
    }
}

struct CalculatorCard: View {
    
    var image: String
    var title: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.all, 20)
                .foregroundColor(.accentColor)
            
            Text(LocalizedStringKey(title))
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(UIColor.secondarySystemBackground))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
//            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
    
}
