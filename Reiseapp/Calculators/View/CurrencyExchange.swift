//
//  CurrencyCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct CurrencyExchange: View {
    @StateObject var viewModel = FetchData()
    @State var searchQuery = ""
    
    var body: some View {
        let sortedData = viewModel.conversionData.sorted{
            return $0.currencyName < $1.currencyName
        }
        VStack{
            //Search Bar
            HStack(spacing: 15){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(.gray)
                TextField("Search", text: $searchQuery)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.05))
            .cornerRadius(8)
            .padding()
            
            // List of Currency Exchange Rates
            if sortedData.isEmpty{
                ProgressView()
            }
            else{
                ScrollView{
                    //Fetched Data
                    LazyVStack(alignment: .leading, spacing: 15, content: {
                        ForEach(sortedData) { rate in
                            HStack(spacing: 15){
                                
                                Text(getFlag(currency: rate.currencyName))
                                    .font(.system(size: 65))

                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(rate.currencyName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text("\(rate.currencyValue)")
                                        .fontWeight(.heavy)
                                })
                            }
                            .padding(.horizontal)
                        }
                    })
                    .padding(.top)
                }
            }
        }
    }
    // getting Country Flag by currency name
    func getFlag(currency: String)->String{
        let base = 127397
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        for i in code.utf16{
            if UnicodeScalar(base + Int(i)) != nil {
                scalar.append(UnicodeScalar(base + Int(i))!)
            }
        }
        return String(scalar)
    }
}
