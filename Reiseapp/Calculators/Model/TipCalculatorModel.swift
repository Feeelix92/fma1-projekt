//
//  TipCalculatorModel.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 30.05.21.
//

import Foundation

typealias TipAndTotal = (tipAmt: Double, total: Double)

class TipCalculatorModel {
    var total: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
 
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTip(withTipPct tipPct: Double) -> TipAndTotal {
        let tipAmt = subtotal * tipPct
        return (tipAmt, total + tipAmt)
    }
    
    func returnPossibleTips() -> [Int: TipAndTotal] {
        let possibleTips = [0.15, 0.18, 0.20]
        var retval = [Int: TipAndTotal]()
        for possibleTip in possibleTips {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTip(withTipPct: possibleTip)
        }
        return retval
    }
}
