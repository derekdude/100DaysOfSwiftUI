//
//  HabitArray.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import Foundation
import SwiftUI

enum CodingKeys: CodingKey {
    case habits
}

class HabitArray: ObservableObject
{
    @Published var habits = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.habits = decoded
                return
            }
        }

        self.habits = []
    }
    /*required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        habits = try container.decode([Habit].self, forKey: .habits)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(habits, forKey: .habits)
    }*/
    
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
