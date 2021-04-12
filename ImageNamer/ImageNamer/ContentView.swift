//
//  ContentView.swift
//  ImageNamer
//
//  Created by Derek Santolo on 4/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var pictures: [Picture]
    
    var body: some View {
        NavigationView {
            List {
                Text("Image 1")
                Text("Image 2")
                Text("Image 3")
            }
            .navigationTitle("Images")
            .navigationBarTitle("ImageNamer")
        }
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pictures: [])
    }
}*/
