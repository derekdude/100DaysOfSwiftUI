//
//  AddView.swift
//  iExpense
//
//  Created by Derek Santolo on 11/9/20.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingError = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView
        {
            Form
            {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type)
                {
                    ForEach(Self.types, id: \.self)
                    {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        if let actualAmount = Int(self.amount)
                                        {
                                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                                            self.expenses.items.append(item)
                                            
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        
                                        else
                                        {
                                            showingError = true
                                        }
                                    })
            .alert(isPresented: $showingError, content: {
                Alert(title: Text("Invalid Integer"), message: Text("Must enter a valid integer."), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
