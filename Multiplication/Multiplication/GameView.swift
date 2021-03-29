//
//  GameView.swift
//  Multiplication
//
//  Created by Derek Santolo on 11/6/20.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct GameView: View
{
    @State var numQuestions: String
    @State var gameOver = false
    @State var asked = 0
    @State var userAnswer = ""
    @State var questions: [(Int, Int, Int)] = []
    @State var question: (Int, Int, Int)
    @State var numCorrect = 0
    @Binding var gameIsRunning: Bool 

    
    var body: some View {
        Group
        {
            if (!gameOver)
            {
                VStack
                {
                    Text("\(question.0) x \(question.1) = ")
                        .font(.largeTitle)
                    HStack
                    {
                        Spacer()
                        TextField("answer", text: $userAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        Spacer()
                        Button("Submit")
                        {
                            if (Int(userAnswer) == question.2)
                            {
                                numCorrect += 1
                            }
                            else
                            {
                                //wrong answer
                            }
                            userAnswer = ""
                            asked += 1
                            if (asked < Int(numQuestions) ?? 0)
                            {
                                pickQuestion()
                            }
                            else
                            {
                                gameOver = true
                                
                            }
                        }
                        Spacer()
                    }
                }
            }
            else
            {
                VStack
                {
                    Text("Good game! You correctly answered \(numCorrect) out of \(numQuestions) questions! Play again?")
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        gameIsRunning = false
                    }, label: {
                        Text("Yes")
                    })
                }
                
            }
        }
        .onAppear {
            pickQuestion()
        }
    }
    
    func pickQuestion()
    {
        question = questions[Int.random(in: 0...questions.count-1)]
    }
    
    
}

/*struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(question: (0,0,0))
    }
}*/
