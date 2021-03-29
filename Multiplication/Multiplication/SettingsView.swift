//
//  SettingsView.swift
//  Multiplication
//
//  Created by Derek Santolo on 11/5/20.
//

import SwiftUI

struct SettingsView: View {
    @Binding var questionAmountsIndex: Int
    @Binding var questionAmounts: [String]
    @Binding var maxValue: Int
    @Binding var gameIsRunning: Bool
    var generateQuestions: () -> Void
    
    var body: some View {
        VStack
        {
            Text("Multiplication Settings")
                .font(.largeTitle)
            Text("Please choose the largest number you want to multiply with, and how many questions you wish to answer.")
                .font(.headline)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            Spacer()
            Text("\(maxValue)")
                .font(.largeTitle)
            Spacer()
            HStack
            {
                Spacer()
                Button(action: {
                    if (maxValue>1) {maxValue -= 1}
                }, label: {
                    Image(systemName: "arrow.down")
                })
                Spacer()
                Button(action: {
                    if (maxValue<12) {maxValue += 1}
                }, label: {
                    Image(systemName: "arrow.up")
                })
                Spacer()
            }
            Spacer()
            HStack
            {
                Spacer()
                Text("Number of questions: ")
                Stepper(value: $questionAmountsIndex, in: 0...4, step: 1)
                {
                    Text("\(questionAmounts[questionAmountsIndex])")
                }
                Spacer()
            }
            Spacer()
            BeginButton(gameIsRunning: $gameIsRunning, generateQuestions: generateQuestions)
        }
    }
}

/*struct SettingsView_Previews: PreviewProvider {
    @State var squestionAmountsIndex = 0
    @State var squestionAmounts = ["5", "10"]
    @State var smaxValue = 6
    
    static var previews: some View {
        SettingsView(questionAmountsIndex: squestionAmountsIndex, questionAmounts: squestionAmounts, maxValue: smaxValue)
    }
}*/
