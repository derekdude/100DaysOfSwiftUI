//
//  ContentView.swift
//  Multiplication
//
//  Created by Der/Users/dereksantolo/Programming/100DaysOfSwiftUI/Multiplication/Multiplication/GameView.swiftek Santolo on 11/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var gameIsRunning = false
    @State private var maxValue = 6
    @State private var questionAmountsIndex = 0
    @State private var questionAmounts = ["5","10","15","20", "all"]
    @State var questions: [(Int, Int, Int)] = []
    
    var body: some View
    {
            if (gameIsRunning)
            {
                    GameView(numQuestions: questionAmounts[questionAmountsIndex], questions: questions, question: (0,0,0), gameIsRunning: $gameIsRunning)
            }
            else
            {
                SettingsView(questionAmountsIndex: $questionAmountsIndex, questionAmounts: $questionAmounts, maxValue: $maxValue, gameIsRunning: $gameIsRunning, generateQuestions: {self.generateQuestions()})
            }
    }
    
    func generateQuestions()
    {
        for num in 1...maxValue
        {
            for numNext in 1...num
            {
                questions.append((numNext, num, numNext*num))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
