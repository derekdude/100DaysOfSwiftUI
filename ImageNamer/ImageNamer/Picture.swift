//
//  Picture.swift
//  ImageNamer
//
//  Created by Derek Santolo on 4/13/21.
//

import Foundation
import SwiftUI


struct Picture: Identifiable, Hashable {
    var id: String
    private var image: Image
    
    init(inID: String, inImage: Image) {
        id = inID
        image = inImage
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
