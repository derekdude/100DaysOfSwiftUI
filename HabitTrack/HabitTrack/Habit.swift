//
//  Habit.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import SwiftUI

struct Habit: View, Hashable
{
    var name: String
    var description: String
    var timesCompleted: String = "0"
    
    var body: some View
    {
            HStack
            {
                Text("\(name)")
                    .fontWeight(.heavy)
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Text("\(timesCompleted)")
                    .padding()
            }
    }
}

struct Habit_Previews: PreviewProvider {
    static var previews: some View {
        Habit(name: "Habit", description: "This is a habit description.", timesCompleted: "0")
    }
}
