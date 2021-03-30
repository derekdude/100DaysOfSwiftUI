//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Derek Santolo on 12/28/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form
        {
            Section
            {
                TextField("Name", text: $order.orderData.name)
                TextField("Street Address", text: $order.orderData.streetAddress)
                TextField("City", text: $order.orderData.city)
                TextField("Zip", text: $order.orderData.zip)
            }
            
            Section
            {
                NavigationLink(destination:
                                CheckoutView(order: order)) {
                        Text("Check out")
                }
            }
            .disabled(order.orderData.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
