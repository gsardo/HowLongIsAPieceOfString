//
//  ContentView.swift
//  HowLongIsAPieceOfString
//
//  Created by Giuseppe Sardo on 25/4/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 100.0
    @State private var inputMetric = "Meters"
    @State private var outputMetric = "Kilometers"
    
    let metrics = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    var convertedAmount: String {
        let inputToMetersMultiplier: Double
        let outputToMetersMultiplier: Double
        
        switch inputMetric {
        case "Feet":
            inputToMetersMultiplier = 0.3048
        case "Kilometers":
            inputToMetersMultiplier = 1000
        case "Miles":
            inputToMetersMultiplier = 1609.34
        case "Yards":
            inputToMetersMultiplier = 0.9144
        default:
            inputToMetersMultiplier = 1.0
        }
        
        switch outputMetric {
        case "Feet":
            outputToMetersMultiplier = 3.28084
        case "Kilometers":
            outputToMetersMultiplier = 0.001
        case "Miles":
            outputToMetersMultiplier = 0.000621371
        case "Yards":
            outputToMetersMultiplier = 1.09361
        default:
            outputToMetersMultiplier = 1.0
        }
        
        let inputInMeters = amount * inputToMetersMultiplier
        let output = inputInMeters * outputToMetersMultiplier
        
        let outputString = output.formatted()
        
        return "\(outputString) \(outputMetric.lowercased())"
    
    }
    
    //@FocusState handles input focus for the view
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount to convert", value: $amount, format: .number).keyboardType(.decimalPad).focused($amountIsFocused)
                } header: {
                    Text("How long is...")
                }
                .textCase(nil)
                
                Section {
                    Picker("Input unit", selection: $inputMetric) {
                        ForEach(metrics, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                        Text("Select your input metric")
                }
                .textCase(nil)
            
                Section {
                    Picker("Output unit", selection: $outputMetric) {
                        ForEach(metrics, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select your output metric")
                }
                .textCase(nil)
                
                Section{
                    Text(convertedAmount)
                } header: {
                    Text("Converted output")
                }
                .textCase(nil)
                
                .navigationTitle("Length converter")
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
