//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

struct CurrencyCalculator: View {
    // Models
    @StateObject var viewModel = FetchCurrencyData()
    @StateObject var currencyCalc = CurrencyCalculatorModel()
    
    // DisclosureGroup helper
    @State private var isCurrencyBaseScrollExpanded = false
    @State private var isCurrencyOutputScrollExpanded = false
    
    // TextField value
    @State private var currencyAmountTextField = ""
    
    // Language Strings
    let tC = String(format: NSLocalizedString("targetCurrency", comment: ""))
    let bC = String(format: NSLocalizedString("baseCurrency", comment: ""))
    let conversionAmount = String(format: NSLocalizedString("conversionAmount", comment: ""))
    let exchangeRates = String(format: NSLocalizedString("exchangeRates", comment: ""))
        
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text(LocalizedStringKey("amount"))
                        .frame(width: 170, alignment: .leading)
                    TextField("", text: $currencyAmountTextField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: currencyAmountTextField){ newValue in
                            currencyCalc.currencyAmount = Double(currencyAmountTextField) ?? 0.0
                            currencyCalc.convert()
                        }
                }
                DisclosureGroup("\(bC): \(currencyCalc.currencyBase)", isExpanded: $isCurrencyBaseScrollExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(viewModel.conversionData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        currencyCalc.currencyBase = rate.currencyName
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
                DisclosureGroup( "\(tC): \(currencyCalc.currencyOutput)", isExpanded: $isCurrencyOutputScrollExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(viewModel.conversionData) { rate in
                                Text(rate.currencyName)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .onTapGesture{
                                        currencyCalc.currencyOutput = rate.currencyName
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
            Divider()
            Text("\(conversionAmount): " + String(format: "%0.2f", currencyCalc.convertedAmount))
            Divider()
            NavigationLink(
                destination: CurrencyExchange().environmentObject(FetchCurrencyData(currencyBase: currencyCalc.currencyBase))) {
                CalculatorCard(image: "banknote", title: "\(exchangeRates) \(currencyCalc.currencyBase)")
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
        .padding()
        .navigationBarTitle(LocalizedStringKey("currencyCalculator"), displayMode: .inline)
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
