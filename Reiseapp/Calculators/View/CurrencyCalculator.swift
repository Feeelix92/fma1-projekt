//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

struct CurrencyCalculator: View {
    @State var currencyAmountTextField = ""
    @State var currencyBaseTextField = ""
    @State var currencyOutputTextField = ""
    let currencyCalc = CurrencyCalculatorModel(currencyBase: "EUR", currencyOutput: "USD", currencyAmount: 33.25, exchangeRate: 0.75)
    
    var body: some View {
        VStack{
            HStack{
                Text("Ausgangswährung:")
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $currencyBaseTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
            }
            HStack{
                Text("Zielwährung:")
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $currencyOutputTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            HStack{
                Text("Betrag:")
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $currencyAmountTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            Button(action: {
                // Button Action
            }, label: {
                Text("Calculate")
            })
            NavigationLink(
                destination: CurrencyExchange()) {
                CalculatorCard(image: "banknote", title: "Wechselkurse")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .navigationBarTitle("Währungsrechner", displayMode: .inline)
        .background(Color.green)
        .padding()
        .onAppear {
            currencyAmountTextField = String(format: "%0.2f", currencyCalc.currencyAmount)
            currencyBaseTextField = String(format: "%0.2f", currencyCalc.currencyBase)
            currencyOutputTextField = String(format: "%0.2f", currencyCalc.currencyOutput)
        }
    }
}

struct CurrencyCalculator_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCalculator()
    }
}
