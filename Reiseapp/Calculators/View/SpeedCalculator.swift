//
//  SpeedCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI

struct SpeedCalculator: View {
    @State var fromValue = ""
    @State var toValue = ""
    @State var fromUnit = Speed.metersPerSecond
    @State var toUnit = Speed.kilometersPerHour
    
    let speedCalculatorModel = SpeedCalculatorModel(fromValue: 0.0, toValue: 0.0, fromUnit: Speed.metersPerSecond.asUnit, toUnit: Speed.kilometersPerHour.asUnit)
    
    var body: some View {
        VStack {
                HStack(alignment: .top, spacing: 12) {
                    VStack {
                        TextField("", text: $fromValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: fromValue) {
                                speedCalculatorModel.fromValue = Double($0) ?? 0.0
                                speedCalculatorModel.calculate(direction: .Forward, fromUnit: fromUnit.asUnit, toUnit: toUnit.asUnit)
                                toValue = String(speedCalculatorModel.toValue)
                            }
                        Text("Von")
//                        DropDown(items: Speed.allCases, selectedIndex: $fromUnit)
//                            .onChange(of: fromUnit) {
//                                speedCalculatorModel.calculate(direction: .Forward, fromUnit: $0.asUnit, toUnit: toUnit.asUnit)
//                                toValue = String(speedCalculatorModel.toValue)
//                            }
                    }
                    Text("=").padding(6)
                    VStack {
                        TextField("", text: $toValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: toValue) {
                                speedCalculatorModel.toValue = Double($0) ?? 0.0
                                speedCalculatorModel.calculate(direction: .Backward, fromUnit: fromUnit.asUnit, toUnit: toUnit.asUnit)
                                fromValue = String(speedCalculatorModel.fromValue)
                            }
                        Text("Nach")
//                        DropDown(items: Speed.allCases, selectedIndex: $toUnit)
//                            .onChange(of: toUnit) {
//                                speedCalculatorModel.calculate(direction: .Backward, fromUnit: fromUnit.asUnit, toUnit: $0.asUnit)
//                                fromValue = String(speedCalculatorModel.fromValue)
//                            }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Geschwindigkeitsrechner", displayMode: .inline)
            .onAppear {
                
            }
            .padding()
    }
}

struct SpeedCalculator_Previews: PreviewProvider {
    static var previews: some View {
        SpeedCalculator()
    }
}


enum Speed: String, CaseIterable {
    case metersPerSecond, kilometersPerHour, milesPerHour, knots
    
    var asUnit: UnitSpeed {
        switch self {
        case .metersPerSecond:
            return UnitSpeed.metersPerSecond
        case .kilometersPerHour:
            return UnitSpeed.kilometersPerHour
        case .milesPerHour:
            return UnitSpeed.milesPerHour
        case .knots:
            return UnitSpeed.knots
        }
    }
}

