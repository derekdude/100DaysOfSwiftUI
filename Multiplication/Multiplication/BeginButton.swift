//
//  BeginButton.swift
//  Multiplication
//
//  Created by Derek Santolo on 11/6/20.
//

import SwiftUI

struct BeginButton: View
{
    @Binding var gameIsRunning: Bool
    var generateQuestions: () -> Void
    
    var body: some View
    {
        Button(action: {
                gameIsRunning = true
            self.generateQuestions()
        }, label: {
            Text("Begin")
                .foregroundColor(.white)
                .border(Color.black)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .font(.largeTitle)
        })
    }
}

/*struct BeginButton_Previews: PreviewProvider {
    static var previews: some View {
        BeginButton()
    }
}*/
