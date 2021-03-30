//
//  ContentView.swift
//  WeSplit
//
//  Created by Derek Santolo on 10/1/20.
//

import SwiftUI

struct ContentView: View
{
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: (Double, Double)
    {
        let peopleCount = Double(Int(numberOfPeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return (amountPerPerson, grandTotal)
    }
    
    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section
                {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?"))
                {
                    Picker("Tip percentage", selection: $tipPercentage)
                    {
                        ForEach(0 ..< tipPercentages.count)
                        {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            
                
                Section(header: Text("Amount per person"))
                {
                    Text("$\(totalPerPerson.0, specifier: "%.2f")")
                }
                
                Section (header: Text("Total Check Amount"))
                {
                    Text("$\(totalPerPerson.1, specifier: "%.2f")")
                }
                .foregroundColor(tipPercentage==4 ? .red : nil)
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
