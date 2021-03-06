//
//  ContentView.swift
//  Moonshot
//
//  Created by Derek Santolo on 11/12/20.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var launchDateInfo: Bool = true
    
    var body: some View {
        NavigationView {
            List(missions)
            { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading)
                    {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(launchDateInfo==true ? mission.formattedLaunchDate : mission.formattedCrewList)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Toggle Info") {
                launchDateInfo.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
