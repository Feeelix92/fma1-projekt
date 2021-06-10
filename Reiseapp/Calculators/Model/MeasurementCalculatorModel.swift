//
//  MeasurementCalculatorModel.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 09.06.21.
//

import Foundation

class MeasurementCalculatorModel {
    var fromValue: Double
    var toValue: Double
    var fromUnit: UnitLength
    var toUnit: UnitLength
    
    init(fromValue: Double, toValue: Double, fromUnit: UnitLength, toUnit: UnitLength) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.fromUnit = fromUnit
        self.toUnit = toUnit
    }
    
    var fromMeasurement: Measurement<UnitLength> {
        return Measurement(value: fromValue, unit: fromUnit)
    }
    
    var toMeasurement: Measurement<UnitLength> {
        return Measurement(value: toValue, unit: toUnit)
    }
    
    func calculate(direction: Direction, fromUnit: UnitLength, toUnit: UnitLength) {
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        if direction == .Forward {
            let convertedMeasurement = fromMeasurement.converted(to: toUnit)
            toValue = convertedMeasurement.value
        } else {
            let convertedMeasurement = toMeasurement.converted(to: fromUnit)
            fromValue = convertedMeasurement.value
        }
    }
}

enum Direction {
    case Forward
    case Backward
}
