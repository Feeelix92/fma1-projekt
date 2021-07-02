//
//  CurrencyCalculatorModel.swift
//  Reiseapp
//
//  Created by FMA1 on 01.06.21.
//

import Foundation

class CurrencyCalculatorModel: ObservableObject {
    @Published var currencyBase: String = "EUR"
    @Published var currencyOutput: String = "USD"
    @Published var currencyAmount: Double = 0.0
    @Published var convertedAmount: Double = 0.0
    
    func convert(){
        let urlData = "convert?from=\(self.currencyBase)&to=\(self.currencyOutput)&amount=\(self.currencyAmount)"
        let url = "https://api.exchangerate.host/\(urlData)"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let JSONDData = data else {return}

            do{
                let conversion  = try JSONDecoder().decode(ConversionConvert.self, from: JSONDData)
                // Converting Dictionary To Array of Objects
                
                DispatchQueue.main.async {
                    self.convertedAmount = conversion.result
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}

