//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Derek Santolo on 10/5/20.
//

import SwiftUI

struct FlagView: View
{
    var country: String

    var body: some View
    {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var gotCorrectAnswer = false
    @State private var flagChosen = 0
    @State private var animationAmount = 0.0
    @State private var opacityAnimVal = 1.0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack
        {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30)
            {
                VStack()
                {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagChosen = number
                            gotCorrectAnswer = self.flagTapped(number)
                            if (gotCorrectAnswer)
                            {
                                    withAnimation
                                    {
                                        self.animationAmount += 360
                                        self.opacityAnimVal = 0.25
                                    }
                            }
                            else
                            {
                                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1))
                                {
                                    self.animationAmount += 360
                                    self.opacityAnimVal = 0.25
                                }
                            }
                        })
                        {
                                FlagView(country: self.countries[number])
                                    .rotation3DEffect(
                                        .degrees(number==correctAnswer ? animationAmount : 0),
                                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
                                    .opacity(number == correctAnswer ? 1 : opacityAnimVal)
                        }
                    }
                    
                
                    Label("Score: \(score)", systemImage: "bolt.fill")
                        .labelStyle(TitleOnlyLabelStyle())
                        .foregroundColor(.white)
                    Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            var alert: Alert
            if gotCorrectAnswer
            {
               alert = Alert(title: Text(scoreTitle), message: Text("Correct! Your Score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
            else
            {
               alert = Alert(title: Text(scoreTitle), message: Text("Wrong! That's the flag of \(countries[flagChosen]). Your Score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
            return alert
        }
    }
    
    func flagTapped(_ number: Int) -> Bool {
        showingScore = true
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
            return true
        }
        
        else {
            scoreTitle = "Wrong"
            score-=1
            return false
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAnimVal = 1
        animationAmount = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
