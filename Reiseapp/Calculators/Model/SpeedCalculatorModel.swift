//
//  SpeedCalculatorModel.swift
//  Reiseapp
//
//  Created by FMA1 on 10.06.21.
//


import Foundation

class SpeedCalculatorModel {
    var fromValue: Double
    var toValue: Double
    var fromUnit: UnitSpeed
    var toUnit: UnitSpeed
    
    init(fromValue: Double, toValue: Double, fromUnit: UnitSpeed, toUnit: UnitSpeed) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.fromUnit = fromUnit
        self.toUnit = toUnit
    }
    
    var fromSpeed: Measurement<UnitSpeed> {
        return Measurement(value: fromValue, unit: fromUnit)
    }
    
    var toSpeed: Measurement<UnitSpeed> {
        return Measurement(value: toValue, unit: toUnit)
    }
    
    func calculate(direction: Direction, fromUnit: UnitSpeed, toUnit: UnitSpeed) {
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        if direction == .Forward {
            let convertedSpeed = fromSpeed.converted(to: toUnit)
            toValue = convertedSpeed.value
        } else {
            let convertedSpeed = toSpeed.converted(to: fromUnit)
            fromValue = convertedSpeed.value
        }
    }
}

