//
//  ContentView.swift
//  Drawing
//
//  Created by Derek Santolo on 12/9/20.
//

import SwiftUI

struct Arrow: InsettableShape
{
    var rectangleWidth: CGFloat = 40
    var triangleBase: CGFloat = 150
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path
    {
        var path = Path()
        
        //rectangle
        path.move(to: CGPoint(x: rect.midX - (rectangleWidth/2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.midY))
        
        //triangle
        path.addLine(to: CGPoint(x: rect.midX + (triangleBase / 2), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - (triangleBase / 2), y: rect.midY))
        
        //rectangle
        path.addLine(to: CGPoint(x: rect.midX - (rectangleWidth / 2), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - (rectangleWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.maxY))
         
        return path
    }
    
    //Challenge 2:
    func inset(by amount: CGFloat) -> some InsettableShape
    {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ContentView: View {
    @State private var arrowLineThickness: CGFloat = 1
    var body: some View {
        VStack
        {
            Arrow()
                .strokeBorder(Color.blue, lineWidth: arrowLineThickness)
                .frame(width: 300, height: 300)
            
            Button("Border Size")
            {
                withAnimation(.linear(duration: 2))
                {
                    self.arrowLineThickness = self.arrowLineThickness == 1 ? 20 : 1
                }
            }
            .padding()
            
            Challenge3()
            
        }
        .navigationBarTitle("Drawing Challenges", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
