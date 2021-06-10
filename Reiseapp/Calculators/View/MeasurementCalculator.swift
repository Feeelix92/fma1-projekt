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
    @State var fromUnit = Length.meter
    @State var toUnit = Length.kilometer
    
    let measurementCalculatorModel = MeasurementCalculatorModel(fromValue: 0.0, toValue: 0.0, fromUnit: Length.meter.asUnit, toUnit: Length.kilometer.asUnit)
    
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
                        Text("Von")
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
                        Text("Nach")
                        DropDown(items: Length.allCases, selectedIndex: $toUnit)
                            .onChange(of: toUnit) {
                                measurementCalculatorModel.calculate(direction: .Backward, fromUnit: fromUnit.asUnit, toUnit: $0.asUnit)
                                fromValue = String(measurementCalculatorModel.fromValue)
                            }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Längenrechner", displayMode: .inline)
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
    case kilometer, meter, zentimeter, millimeter, mikrometer, nanometer, meile, yard, fuß, zoll, seemeile
    
    var asUnit: UnitLength {
        switch self {
        case .kilometer:
            return UnitLength.kilometers
        case .meter:
            return UnitLength.meters
        case .zentimeter:
            return UnitLength.centimeters
        case .millimeter:
            return UnitLength.millimeters
        case .mikrometer:
            return UnitLength.micrometers
        case .nanometer:
            return UnitLength.nanometers
        case .meile:
            return UnitLength.miles
        case .yard:
            return UnitLength.yards
        case .fuß:
            return UnitLength.feet
        case .zoll:
            return UnitLength.inches
        case .seemeile:
            return UnitLength.nauticalMiles
        }
    }
}
