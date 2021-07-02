//
//  SpeedCalculatorModel.swift
//  Reiseapp
//
//  Created by FMA1 on 10.06.21.
//


import Foundation

class SpeedCalculatorModel: ObservableObject{
    var currentSpeed: Double = 0.0
    var selectedInputSpeed: UnitSpeed = .kilometersPerHour
    let formatter = MeasurementFormatter()
    @Published var metersPerSecond: String = "0.0"
    @Published var kilometersPerHour: String = "0.0"
    @Published var milesPerHour: String = "0.0"
    @Published var knots: String = "0.0"
    @Published var units: [String] = []
    
    var fromSpeed: Measurement<UnitSpeed> {
        return Measurement(value: currentSpeed, unit: selectedInputSpeed)
    }
    
    func convertSpeed(){
        formatter.unitOptions = [.providedUnit]
        metersPerSecond = formatter.string(from: fromSpeed.converted(to: .metersPerSecond))
        kilometersPerHour = formatter.string(from: fromSpeed.converted(to: .kilometersPerHour))
        milesPerHour = formatter.string(from: fromSpeed.converted(to: .milesPerHour))
        knots = formatter.string(from: fromSpeed.converted(to: .knots))
        switch selectedInputSpeed {
        case .metersPerSecond:
            units = [kilometersPerHour, milesPerHour, knots]
        case .kilometersPerHour:
            units = [metersPerSecond, milesPerHour, knots]
        case .milesPerHour:
            units = [metersPerSecond, kilometersPerHour, knots]
        case .knots:
            units = [metersPerSecond, kilometersPerHour, milesPerHour]
        default:
            units = [metersPerSecond, kilometersPerHour, milesPerHour, knots]
        }
    }
}

