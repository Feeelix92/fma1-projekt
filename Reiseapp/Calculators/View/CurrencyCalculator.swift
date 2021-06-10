//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

struct CurrencyCalculator: View {
    @StateObject var viewModel = FetchCurrencyData()

    @State private var isExpanded = false
    @State private var selectedCurrency = "EUR"
    @State private var isCurrencyBaseScrollExpanded = false
    @State private var isCurrencyOutputScrollExpanded = false
    @State private var selectedCurrencyBase = "EUR"
    @State private var selectedCurrencyOutput = "USD"
    @State var currencyAmountTextField = ""
    
    let currencyCalc = CurrencyCalculatorModel(currencyBase: "EUR", currencyOutput: "USD", currencyAmount: 33.25, exchangeRate: 0.75)
    
    var body: some View {
        let sortedData = viewModel.conversionData.sorted{
            return $0.currencyName < $1.currencyName
        }
        VStack{
            VStack{
                DisclosureGroup("Ausgangswährung: \(selectedCurrencyBase)", isExpanded: $isCurrencyBaseScrollExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(sortedData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        self.selectedCurrencyBase = rate.currencyName
                                        withAnimation{
                                            self.isCurrencyBaseScrollExpanded.toggle()
                                        }
                                    }
                            }
                        }
                    }
                    .frame(height: 150, alignment: .leading)
                }
                DisclosureGroup("Zielwährung: \(selectedCurrencyOutput)", isExpanded: $isCurrencyOutputScrollExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(sortedData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        self.selectedCurrencyOutput = rate.currencyName
                                        withAnimation{
                                            self.isCurrencyOutputScrollExpanded.toggle()
                                        }
                                    }
                            }
                        }
                    }
                    .frame(height: 150, alignment: .leading)
                }
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
            Spacer()
        }
        .padding()
        .navigationBarTitle("Währungsrechner", displayMode: .inline)
        .onAppear {
            currencyAmountTextField = String(format: "%0.2f", currencyCalc.currencyAmount)
        }
    }
}

struct CurrencyCalculator_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCalculator()
    }
}
