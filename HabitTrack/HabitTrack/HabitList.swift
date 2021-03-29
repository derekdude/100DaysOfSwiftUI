//
//  HabitList.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import SwiftUI

struct HabitList: View
{
    @ObservedObject var habitHolder: HabitArray
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ForEach(habitHolder.habits, id: \.self)
                { habit in
                    habit
                }
            }
            .navigationBarItems(leading: Text("Habits")
                    .font(.largeTitle),
                    trailing: NavigationLink(
                        destination: AddHabit(habitHolder: habitHolder),
                        label: {
                            Image(systemName: "plus")
                        }))
        }
    }
}

struct HabitList_Previews: PreviewProvider {
    static var habits = HabitArray()
    
    static var previews: some View {
        HabitList(habitHolder: habits)
    }
}
