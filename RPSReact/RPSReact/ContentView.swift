//
//  ContentView.swift
//  RPSReact
//
//  Created by Derek Santolo on 10/10/20.
//

import SwiftUI

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
    @State private var isShowingEndView = false
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random() ? "Win" : "Lose"
    @State private var score = 0
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center)
                {
                    NavigationLink(destination: EndView(score: score), isActive: $isShowingEndView) {EmptyView()}
                    HStack {
                        Text("Score: ")
                            .font(.custom("Georgia", size: 24, relativeTo: .headline))
                            .shadow(radius: 50)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("\(score)")
                            .font(.custom("Georgia", size: 24))
                        
                    }
                        
                    Text("\(shouldWin) against")
                        .font(.title3)
                        .offset(y: 50)
                    Spacer()
                    
                    MoveView(move: possibleMoves[currentMove], isOpponentMove: true)
                    
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
                        .padding()
                    }
                    .padding()
                    
                    Text("icons by icons8")
                        .fontWeight(.ultraLight)
                        .offset(y: 24)
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
        
        if(questionCount==10) { isShowingEndView = true}
        
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random() ? "Win" : "Lose"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
