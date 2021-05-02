//
//  MoveView.swift
//  RPSReact
//
//  Created by Derek Santolo on 4/21/21.
//

import SwiftUI

struct MoveView: View
{
    var move: String
    var isShowingImage = true
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
            VStack (alignment: .center) {
                    Image(imageName)
                        .rotationEffect(Angle(degrees: 360))
                    Text(move)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .autocapitalization(.allCharacters)
                        .foregroundColor(fontColor)
                }
            .frame(maxWidth: .infinity,  alignment: .center)
            .aspectRatio(contentMode: .fit)        
    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        MoveView(move: "Rock")
    }
}
