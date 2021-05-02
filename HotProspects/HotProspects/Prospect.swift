//
//  Prospect.swift
//  HotProspects
//
//  Created by Derek Santolo on 4/23/21.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name
    }
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
}

class Prospects: ObservableObject {
    @Published private(set) var people = [Prospect]()
    static let saveKey = "SavedData"
    
    init() {
        //UserDefaults code:
        /*if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }*/
        
        // DocumentsDirectory code:
        let url = self.getDocumentsDirectory().appendingPathExtension("people.json")
        do {
               let savedData = try Data(contentsOf: url)
               if let decoded = try? JSONDecoder().decode([Prospect].self, from: savedData) {
                people = decoded
                return
            }
        }
        catch {
            print("Unable to read the file")
        }

        self.people = []
    }
        
    private func save() {
        //UserDefaults code:
        
        /*if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }*/
        
        // Documents Directory code: 
        if let encoded = try? JSONEncoder().encode(people) {
            let url = self.getDocumentsDirectory().appendingPathExtension("people.json")
            
            do {
                try encoded.write(to: url)
                print("File saved: \(url.absoluteURL)")
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

