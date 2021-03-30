//
//  ContentView.swift
//  EasyConvert
//
//  Created by Derek Santolo on 10/4/20.
//

import SwiftUI

struct ContentView: View
{
    @State private var inAmount = "0"
    @State private var inUnit = 0
    @State private var outUnit = 1
    
    let tempUnits: [String] = ["Fahrenheit", "Celsius", "Kelvin"]
     
    var input: (Double, String)
    {
        if let inAmountDoub = Double(inAmount)
        {
            return (inAmountDoub, tempUnits[inUnit])
        }
        else
        {
            print("Not a valid number.")
            return (0.0, "")
        }
    }
    
    var outAmount: Double
    {
        let conversion: (String, String) = (tempUnits[inUnit], tempUnits[outUnit])
        let match: Bool = conversion.0==conversion.1
         
        if (match)
        {
            return Double(inAmount) ?? 0.0
        }
        
        else
        {
            let inAmountDoub = Double(inAmount) ?? 0
            switch conversion
            {
                case ("Fahrenheit", "Celsius"):
                    return (inAmountDoub - 32) * 9/5
                case ("Celsius", "Fahrenheit"):
                    return (inAmountDoub * 9/5) + 32
                case ("Fahrenheit", "Kelvin"):
                    return (((inAmountDoub - 32) * 5/9) + 273)
                case ("Kelvin", "Fahrenheit"):
                    return (((inAmountDoub - 273) * 9/5) + 32)
                case ("Kelvin", "Celsius"):
                    return Double(inAmount) ?? 0 - 273
                case ("Celsius", "Kelvin"):
                    return Double(inAmount) ?? 0 + 273
                default:
                    return 0.0
            }
        }
    }
    
    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section(header: Text("Input unit and amount"))
                {
                    Picker("Unit", selection: $inUnit)
                    {
                        ForEach(0..<tempUnits.count)
                        {
                            Text("\(self.tempUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Amount", text: $inAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Output unit and amount"))
                {
                    Picker("Unit", selection: $outUnit)
                    {
                        ForEach(0..<tempUnits.count)
                        {
                            Text("\(self.tempUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(self.outAmount, specifier: "%.f")")
                }
            }
            .navigationBarTitle(Text("EasyConvert"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
