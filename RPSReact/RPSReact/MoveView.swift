//
//  MoveView.swift
//  RPSReact
//
//  Created by Derek Santolo on 4/21/21.
//

import SwiftUI

struct MoveView: View
{
    let move: String
    var isOpponentMove = false
    var fontColor: Color {
        if isOpponentMove {
            return Color.red
        }
        
        else {
            return Color.black
        }
    }
    var imageName: String {
        switch move {
        case "Rock":
            return "i8rock"
        case "Paper":
            return "i8paper"
        case "Scissors":
            return "i8scissors"
        default:
            return "i8rock"
        }
    }
    
    var body: some View
    {
        VStack {
            Image(imageName)
            Text(move)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .autocapitalization(.allCharacters)
                .foregroundColor(fontColor)
        }
            
    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        MoveView(move: "Rock")
    }
}
