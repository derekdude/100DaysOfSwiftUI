//
//  ContentView.swift
//  BetterRest
//
//  Created by Derek Santolo on 10/11/20.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var bedtime = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
        
    var body: some View {
        return NavigationView
        {
             Form
             {
                Section(header:  Text("When do you want to wake up?").font(.headline))
                 {
                     Text("When do you want to wake up?")
                         .font(.headline)
                     
                     DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                         .labelsHidden()
                         .datePickerStyle(WheelDatePickerStyle())
                 }
                 
                Section(header: Text("Desired amount of sleep")
                            .font(.headline))
                 {
                     Stepper(value: $sleepAmount, in: 4...12, step: 0.25)
                     {
                             Text("\(sleepAmount, specifier: "%g") hours")
                     }
                 }
                 
                Section(header: Text("Daily coffee intake")
                            .font(.headline))
                 {
                    Picker("\(coffeeAmount+1) cup(s)", selection: $coffeeAmount)
                     {
                        ForEach(1..<21)
                        { num in
                            if num==1
                            {
                                Text("\(num) cup")
                            }
                            else
                            {
                                Text("\(num) cups")
                            }
                        }
                     }
                    .pickerStyle(MenuPickerStyle())
                 }
                
                Section(header: Text("Your Ideal Bedtime")
                            .font(.headline))
                {
                    Text("\(bedtime)")
                        .font(.largeTitle)
                }
             }
             .navigationBarTitle("BetterRest")
         }
        .onAppear(perform: {
                    calculateBedtime()
                })
        .onChange(of: wakeUp, perform: { value in
                    calculateBedtime()
                })
        .onChange(of: sleepAmount, perform: { value in
                    calculateBedtime()
                })
        .onChange(of: coffeeAmount, perform: { value in
                    calculateBedtime()
                })
    }
    
    func calculateBedtime()
    {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var sleepTime = ContentView.defaultWakeTime
        
        do
        {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
        bedtime = alertMessage
    }
    
    static var defaultWakeTime: Date
    {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
