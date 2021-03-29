//
//  ContentView.swift
//  RPSReact
//
//  Created by Derek Santolo on 10/10/20.
//

import SwiftUI

struct MoveView: View
{
    let move: String
    
    var body: some View
    {
        Text(move)
            .font(.largeTitle)
            .padding(5)
            .background(Color.white)
            .shadow(radius: 10)
            .border(Color.gray)
            .hoverEffect()
    }
}

struct EndView: View
{
    var score: Int
    
    var body: some View
    {
        ZStack
        {
            Text("Good game! Your score was \(score).")
        }
    }
}


struct ContentView: View
{
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var questionCount = 0
    @State private var isShowingDetailView = false
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random() ? "Win" : "Lose"
    @State private var score = 0
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                LinearGradient(gradient: Gradient(colors: [Color.white, .gray, Color.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack
                {
                    NavigationLink(destination: EndView(score: score), isActive: $isShowingDetailView) {EmptyView()}
                    Text("Score: \(score)")
                    Text("Opponent's Move: \(possibleMoves[currentMove])")
                    Text("Goal: \(shouldWin)")
                    
                    Spacer()
                    
                    HStack
                    {
                        ForEach(0..<3)
                        { number in
                            let move = possibleMoves[number]
                            Button(action: {
                                processAnswer(move)
                            })
                            {
                                MoveView(move: move)
                            }
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("RPSReact")
            }
        }
    }
    
    func processAnswer(_ move: String)
    {
        var didWin: Bool = false
        
        switch possibleMoves[currentMove]
        {
        case "Rock":
            if (shouldWin=="Win" && move=="Paper")
            {
                didWin = true
            }
            else if (shouldWin=="Lose") && ((move=="Paper")==false)
            {
                didWin = true
            }
        case "Paper":
            if (shouldWin=="Win" && move=="Scissors")
            {
                didWin = true
            }
            else if (shouldWin=="Lose") && ((move=="Scissors")==false)
            {
                didWin = true
            }
        case "Scissors":
            if (shouldWin=="Win" && move=="Rock")
            {
                didWin = true
            }
            else if (shouldWin=="Lose") && ((move=="Rock")==false)
            {
                didWin = true
            }
        default:
            didWin = false
        }
        
        if (didWin) { score+=1 }
        else { score-=1 }
        
        questionCount += 1
        
        if(questionCount==10) { isShowingDetailView = true}
        
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random() ? "Win" : "Lose"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
