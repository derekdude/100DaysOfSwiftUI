//
//  FilteredList.swift
//  CoreDataProject (iOS)
//
//  Created by Derek Santolo on 2/5/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T>
    {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    var filterKey: String
    var filterValue: String
    let sortDescriptors: [NSSortDescriptor]
    
    enum PredicateType: String
    {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case containsCI = "CONTINS[c]"
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self)
        { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], innerPredicate: PredicateType,
         @ViewBuilder content: @escaping (T) -> Content)
    {
        self.sortDescriptors = sortDescriptors
        self.filterKey = filterKey
        self.filterValue = filterValue
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(innerPredicate.rawValue) %@", filterKey, filterValue))
        self.content = content 
    }
}


