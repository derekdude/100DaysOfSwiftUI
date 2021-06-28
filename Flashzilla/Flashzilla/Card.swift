//
//  Card.swift
//  Flashzilla
//
//  Created by Derek Santolo on 6/22/21.
//

import Foundation

struct Card: Codable {
    let prompt: String
    var answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
