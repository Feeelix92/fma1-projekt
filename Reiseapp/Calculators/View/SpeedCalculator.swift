//
//  SpeedCalculator.swift
//  Reiseapp
//
//  Created by Nicklas Düringer on 24.05.21.
//

import SwiftUI


struct SpeedCalculator: View {
    @State private var isSpeedScrollExpanded = false
    @State private var selectedSpeed = Speed.kmh
    @State private var selectedSpeedTextField: String = ""
    
    @StateObject var speedCalculator = SpeedCalculatorModel()

    var body: some View {
        VStack {
            HStack{
                Text("Geschwindigkeit:")
                    .frame(width: 170, alignment: .leading)
                TextField("", text: $selectedSpeedTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .onChange(of: selectedSpeedTextField){ newValue in
                        speedCalculator.currentSpeed = Double(self.selectedSpeedTextField)!
                    }
            }
            Picker("Ausgangseinheit", selection: $selectedSpeed){
                ForEach(Speed.allCases){ speed in
                    Text(speed.rawValue)
                        .tag(speed)
                }
            }.onChange(of: selectedSpeed, perform: { (value) in
                speedCalculator.selectedInputSpeed = selectedSpeed.asUnit
                speedCalculator.convertSpeed()
            })
            .pickerStyle(SegmentedPickerStyle())
            Divider()
            Button(action: {
                // Button Action
                speedCalculator.currentSpeed = Double(selectedSpeedTextField) ?? 0.0
                speedCalculator.selectedInputSpeed = selectedSpeed.asUnit
                speedCalculator.convertSpeed()
                    
            }, label: {
                Text("Calculate")
                    .font(.title2)
            })
            Divider()
            if  speedCalculator.converted{
                VStack(spacing: 10) {
                    Text(speedCalculator.metersPerSecond)
                    Text(speedCalculator.kilometersPerHour)
                    Text(speedCalculator.milesPerHour)
                    Text(speedCalculator.knots)
                }
                
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Geschwindigkeitsrechner", displayMode: .inline)
    }
}

enum Speed: String, CaseIterable, Identifiable{
    case  ms, kmh, mph, knoten
    
    var id: String{self.rawValue}
    var asUnit: UnitSpeed{
        switch self{
        case .ms:
            return UnitSpeed.metersPerSecond
        case .kmh:
            return UnitSpeed.kilometersPerHour
        case .mph:
            return UnitSpeed.milesPerHour
        case .knoten:
            return UnitSpeed.knots
        }
    }
}

