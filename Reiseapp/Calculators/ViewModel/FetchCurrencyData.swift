//
//  FetchCurrencyData.swift
//  Reiseapp
//
//  Created by FMA1 on 27.05.21.
//

import SwiftUI

class FetchCurrencyData: ObservableObject {
    @Published var conversionData : [CurrencyRate] = []
    var currencyBase: String?
    
    init(currencyBase: String? = "EUR") {
        self.currencyBase = currencyBase!
        fetch()
    }
    
    func fetch(){
        let urlData = "latest?base=\(self.currencyBase!)&source=ecb"
        let url = "https://api.exchangerate.host/\(urlData)"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let JSONDData = data else {return}

            do{
                let conversion  = try JSONDecoder().decode(Conversion.self, from: JSONDData)
                // Converting Dictionary To Array of Objects
                
                DispatchQueue.main.async {
                    // Key will be Currency Name
                    // value will be currency Value
                    let data = conversion.rates.compactMap({ (key, value) -> CurrencyRate? in
                    return CurrencyRate(currencyName: key, currencyValue: value)
                    })
                    self.conversionData = data.sorted{
                        return $0.currencyName < $1.currencyName
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
    
