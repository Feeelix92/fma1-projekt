//
//  FetchCurrencyData.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

class FetchCurrencyData: ObservableObject {
    @Published var conversionData : [Currency] = []
    var baseCurrency: String?
    
    init(baseCurrency: String) {
        self.baseCurrency = baseCurrency
        fetch()
    }
    
func fetch(){
        let urlData = "latest?base=" + self.baseCurrency!
        let url = "https://api.exchangerate.host/" + urlData
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let JSONDData = data else {return}

            do{
                let conversion  = try JSONDecoder().decode(Conversion.self, from: JSONDData)
                // Converting Dictionary To Array of Objects
                
                DispatchQueue.main.async {
                    // Key will be Currency Name
                    // value will be currency Value
                    self.conversionData = conversion.rates.compactMap({ (key, value) -> Currency? in
                    return Currency(currencyName: key, currencyValue: value)
                    })
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
    
