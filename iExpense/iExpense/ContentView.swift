//
//  ContentView.swift
//  iExpense
//
//  Created by Derek Santolo on 11/8/20.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(expenses.items)
                { item in
                    HStack
                    {
                        VStack(alignment: .leading)
                        {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        getAmountStyle(amount: String(item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                            Button(action: {
                                self.showingAddExpense = true
                            }) {
                                Image(systemName: "plus")
                            },
                                
                            trailing: EditButton()
            )
            .sheet(isPresented: $showingAddExpense)
            {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet)
    {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func getAmountStyle(amount: String) -> Text
    {
        //var amountView: AnyView = Text()
        
        if let numAmount = Int(amount)
        {
            if (numAmount > 1000)
            {
                return Text("$" + amount).fontWeight(.bold)
            }
            
            else if (numAmount > 100)
            {
                return Text("$" + amount).fontWeight(.semibold)
            }
            
            else if (numAmount > 10)
            {
                return Text("$" + amount).fontWeight(.light)
            }
            
            else
            {
                return Text("$" + amount).fontWeight(.ultraLight)
            }
        }
        
        return Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
