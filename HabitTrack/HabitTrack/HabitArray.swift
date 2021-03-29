//
//  HabitArray.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import Foundation
import SwiftUI

class HabitArray: ObservableObject
{
    @Published var habits: [Habit] = [Habit]()
    
    func addHabit(_ habit: Habit) -> Bool
    {
        if(habits.contains(where: { element in element.name==habit.name } ))
        {
            return false
        }
        
        else
        {
            habits.append(habit)
            return true
        }
    }
    
    func removeHabit(_ habit: Habit)
    {
        habits.remove(at: habits.count-1)
    }
}
