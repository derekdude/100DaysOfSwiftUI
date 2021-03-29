//
//  AddHabit.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import SwiftUI

struct AddHabit: View {
    @ObservedObject var habitHolder = HabitArray()
    @State private var habitToAdd = Habit(name: "", description: "")
    @State private var showingAlert = false
    
    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section
                {
                    TextField("Name: ", text: $habitToAdd.name)
                }
                
                Section
                {
                    TextField("Description: ", text: $habitToAdd.description)
                }
                
                Section
                {
                    TextField("Number of Times Completed: ", text: $habitToAdd.timesCompleted)
                        .keyboardType(.decimalPad)
                }
                
                Button("Save")
                {
                    if (!habitHolder.addHabit(habitToAdd))
                    {
                        self.showingAlert = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Habit already exists."), message: Text("Please add a new habit or edit your existing habits."), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarTitle("New Habit")
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit()
    }
}
