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
                Text(LocalizedStringKey("speed"))
                    .frame(width: 150, alignment: .leading)
                TextField("", text: $selectedSpeedTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .onChange(of: selectedSpeedTextField){ newValue in
                        speedCalculator.currentSpeed = Double(self.selectedSpeedTextField) ?? 0.0
                    }
            }
            Picker("baseUnit", selection: $selectedSpeed){
                ForEach(Speed.allCases){ speed in
                    Text(LocalizedStringKey(speed.rawValue))
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
                Text(LocalizedStringKey("calculate"))
                    .font(.title2)
            })
            Divider()
            if  speedCalculator.converted{
                VStack(spacing: 10) {
                    ForEach(speedCalculator.units, id: \.self){ unit in
                        Text(unit)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(LocalizedStringKey("speedCalculator"), displayMode: .inline)
    }
}

enum Speed: String, CaseIterable, Identifiable{
    case  ms = "metersPerSecond", kmh = "kilometersPerHour", mph = "milesPerHour", knots = "knots"
    
    var id: String{self.rawValue}
    var asUnit: UnitSpeed{
        switch self{
        case .ms:
            return UnitSpeed.metersPerSecond
        case .kmh:
            return UnitSpeed.kilometersPerHour
        case .mph:
            return UnitSpeed.milesPerHour
        case .knots:
            return UnitSpeed.knots
        }
    }
}

