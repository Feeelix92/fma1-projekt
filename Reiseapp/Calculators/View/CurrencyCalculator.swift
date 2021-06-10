//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

struct CurrencyCalculator: View {
    @StateObject var viewModel = FetchCurrencyData()
    
    @State private var isCurrencyBaseScrollExpanded = false
    @State private var isCurrencyOutputScrollExpanded = false
    @State private var selectedCurrencyBase = "EUR"
    @State private var selectedCurrencyOutput = "USD"
    @State private var currencyAmount = 33.25
    @State private var convertedCurrencyAmount = 0.0

    @State private var currencyAmountTextField = ""
    
    @StateObject var currencyCalc = CurrencyCalculatorModel(currencyBase: "EUR", currencyOutput: "USD", currencyAmount: 33.25)
    
    var body: some View {
        VStack{
            VStack{
                DisclosureGroup("Ausgangswährung: \(selectedCurrencyBase)", isExpanded: $isCurrencyBaseScrollExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(viewModel.conversionData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        currencyCalc.currencyBase = rate.currencyName
                                        self.selectedCurrencyBase = rate.currencyName
                                        currencyCalc.convert()
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
                            ForEach(viewModel.conversionData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        currencyCalc.currencyOutput = rate.currencyName
                                        self.selectedCurrencyOutput = rate.currencyName
                                        currencyCalc.convert()
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
                    .onChange(of: currencyAmountTextField){ newValue in
                        currencyCalc.currencyAmount = Double(currencyAmountTextField)!
                        currencyCalc.convert()
                    }
            }
            Button(action: {
                // Button Action
                currencyCalc.currencyAmount = Double(currencyAmountTextField)!
                currencyCalc.convert()
                self.convertedCurrencyAmount = currencyCalc.convertedAmount
                print("view: \(self.convertedCurrencyAmount)")
                
            }, label: {
                Text("Calculate")
            })
            Text(String(format: "Umrechnungsbetrag: %0.2f", self.convertedCurrencyAmount))
                .font(.subheadline)
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
