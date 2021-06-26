//
//  TipCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct TipCalculator: View {
    @State var totalTextField = ""
    @State var taxPctSlider = 0.0
    @State var possibleTips = [Int: TipAndTotal]()
    @State var sortedKeys: [Int] = []
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Bill Total (Post-Tax):")
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $totalTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            HStack {
                Text("Tax Percentage (\(Int(taxPctSlider))%)")
                    .frame(width: 170, alignment: .leading)
                Spacer()
                Slider(value: $taxPctSlider, in: 0...10, step: 1, onEditingChanged: { editing in
                    tipCalc.taxPct = Double(self.taxPctSlider) / 100.0
                    
                })
                
            }
            
            Button(action: {
                tipCalc.total = Double(totalTextField)!
                possibleTips = tipCalc.returnPossibleTips()
                sortedKeys = possibleTips.keys.sorted()
                
            }, label: {
                Text(LocalizedStringKey("calculate"))
            })
            
            List { ForEach(sortedKeys, id: \.self) {key in
                let (tipAmt, total) = possibleTips[key]!
                HStack {
                    Text("\(key)%:")
                        .font(.headline)
                    Text(String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmt, total))
                        .font(.subheadline)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            }
            .padding([.top, .bottom, .trailing])
            Spacer()
        }
        .padding()
        .navigationBarTitle(LocalizedStringKey("tipCalculator"), displayMode: .inline)
        .onAppear {
            totalTextField = String(format: "%0.2f", tipCalc.total)
            taxPctSlider = Double(tipCalc.taxPct) * 100.0
        }
    }
}

struct TipCalculator_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculator()
    }
}
