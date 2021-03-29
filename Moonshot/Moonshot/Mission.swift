//
//  Mission.swift
//  Moonshot
//
//  Created by Derek Santolo on 12/6/20.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String
    {
        if let launchDate = launchDate
        {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        else
        {
            return "N/A"
        }
    }
    
    var formattedCrewList: String
    {
        var str: String = ""
        for i in 0..<crew.count-1
        {
            str += "\(crew[i].name.capitalized), "
        }
        
        str += crew[(crew.count)-1].name.capitalized
        
        return str
    }
}
