//
//  MeasurementCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct MeasurementCalculator: View {
    @State var fromValue = ""
    @State var toValue = ""
    @State var fromUnit = Length.meters
    @State var toUnit = Length.kilometers
    
    let measurementCalculatorModel = MeasurementCalculatorModel(fromValue: 0.0, toValue: 0.0, fromUnit: Length.meters.asUnit, toUnit: Length.kilometers.asUnit)
    
    var body: some View {
        VStack {
                HStack(alignment: .top, spacing: 12) {
                    VStack {
                        TextField("", text: $fromValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: fromValue) {
                                measurementCalculatorModel.fromValue = Double($0) ?? 0.0
                                measurementCalculatorModel.calculate(direction: .Forward, fromUnit: fromUnit.asUnit, toUnit: toUnit.asUnit)
                                toValue = String(measurementCalculatorModel.toValue)
                            }
                        Text(LocalizedStringKey("from"))
                        DropDown(items: Length.allCases, selectedIndex: $fromUnit)
                            .onChange(of: fromUnit) {
                                measurementCalculatorModel.calculate(direction: .Forward, fromUnit: $0.asUnit, toUnit: toUnit.asUnit)
                                toValue = String(measurementCalculatorModel.toValue)
                            }
                    }
                    Text("=").padding(6)
                    VStack {
                        TextField("", text: $toValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: toValue) {
                                measurementCalculatorModel.toValue = Double($0) ?? 0.0
                                measurementCalculatorModel.calculate(direction: .Backward, fromUnit: fromUnit.asUnit, toUnit: toUnit.asUnit)
                                fromValue = String(measurementCalculatorModel.fromValue)
                            }
                        Text(LocalizedStringKey("to"))
                        DropDown(items: Length.allCases, selectedIndex: $toUnit)
                            .onChange(of: toUnit) {
                                measurementCalculatorModel.calculate(direction: .Backward, fromUnit: fromUnit.asUnit, toUnit: $0.asUnit)
                                fromValue = String(measurementCalculatorModel.fromValue)
                            }
                    }
                }
                Spacer()
            }
            .navigationBarTitle(LocalizedStringKey("measurementCalculator"), displayMode: .inline)
            .onAppear {
                
            }
            .padding()
    }
}

struct MeasurementCalculator_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementCalculator()
    }
}


enum Length: String, CaseIterable {
    case kilometers, meters, centimeters, millimeters, micrometers, nanometers, miles, yards, feet, inches, nauticalMiles
    
    var asUnit: UnitLength {
        switch self {
        case .kilometers:
            return UnitLength.kilometers
        case .meters:
            return UnitLength.meters
        case .centimeters:
            return UnitLength.centimeters
        case .millimeters:
            return UnitLength.millimeters
        case .micrometers:
            return UnitLength.micrometers
        case .nanometers:
            return UnitLength.nanometers
        case .miles:
            return UnitLength.miles
        case .yards:
            return UnitLength.yards
        case .feet:
            return UnitLength.feet
        case .inches:
            return UnitLength.inches
        case .nauticalMiles:
            return UnitLength.nauticalMiles
        }
    }
}
