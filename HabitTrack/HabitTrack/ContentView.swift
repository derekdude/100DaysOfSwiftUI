//
//  ContentView.swift
//  HabitTrack
//
//  Created by Derek Santolo on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HabitList(habitHolder: HabitArray())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
