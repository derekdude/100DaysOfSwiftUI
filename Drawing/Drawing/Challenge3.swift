//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Derek Santolo on 12/18/20.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View
    {
        ZStack
        {
            ForEach(0..<steps)
            { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 1), color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Challenge3: View {
    @State private var lineWidth = 5.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack
        {
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
                .padding(.bottom, 50)
            
            //Question: How would you make the ColorCyclingRectangle cycle through its colors automatically? 
        }
    }
}

struct Challenge3_Previews: PreviewProvider {
    static var previews: some View {
        Challenge3()
    }
}
