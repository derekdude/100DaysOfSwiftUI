//
//  SettingsSheet.swift
//  Flashzilla
//
//  Created by Derek Santolo on 6/28/21.
//

import SwiftUI

struct SettingsSheet: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var refillingWrongAnswers: Bool
    
    var body: some View {
        VStack {
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            
            HStack {
                VStack {
                    Text("If you answer a card incorrectly, it will return to the card stack instead of being discarded.")
                        .padding()
                        .font(.subheadline)
                }
                
                Toggle("Refill wrong answers", isOn: $refillingWrongAnswers)
            }
        }
    }
}

