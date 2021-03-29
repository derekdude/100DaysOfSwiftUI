//
//  AstronautView.swift
//  Moonshot
//
//  Created by Derek Santolo on 12/7/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.headline)
            
                    ForEach(self.missions, id: \.self)
                    { mission in
                        VStack
                        {
                            Text(mission)
                                .fontWeight(.light)
                        }
                    }
                        
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut)
    {
        self.astronaut = astronaut
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        var matches = [String]()
        
        for mission in allMissions
        {
            if mission.crew.first(where: {$0.name == astronaut.id}) != nil
            {
                matches.append(mission.displayName)
            }
        }

        
        self.missions = matches;
        print(missions); 
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
