//
//  HabitExpand.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/21/20.
//

import SwiftUI

struct HabitExpand: View
{
    @State private var habit = Habit(name: "", description: "")
    @State private var showingAlert = false
    @ObservedObject var habitHolder = HabitArray()
    
    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section
                {
                    TextField("Name: ", text: $habit.name)
                }
                
                Section
                {
                    TextField("Description: ", text: $habit.description)
                }
                
                Section
                {
                    TextField("Number of Times Completed: ", text: $habit.timesCompleted)
                        .keyboardType(.decimalPad)
                }
                
                Button("Save")
                {
                    if (!habitHolder.addHabit(habit))
                    {
                        self.showingAlert = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Habit already exists."), message: Text("A habit with this name already exists."), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarTitle("Edit Habit")
        }
    }
}

struct HabitExpand_Previews: PreviewProvider {
    static var previews: some View {
        HabitExpand()
    }
}
