//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Derek Santolo on 12/29/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View
    {
        GeometryReader
        { geo in
            ScrollView
            {
                VStack
                {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.orderData.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order")
                    {
                        placeOrder()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Check out", displayMode: .inline)
            .alert(isPresented: $showingConfirmation)
            {
                   Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
        
        func placeOrder()
        {
            guard let encoded = try? JSONEncoder().encode(order.orderData)
            else
            {
                print("Failed to encode order")
                return
            }
            
            guard let url = URL(string: "https://reqres.in/api/cupcakes")
            else {
                print("URL Failure")
                return
            }
            var request = URLRequest(url: url)
            request.setValue("application/json",
                             forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encoded
            
            URLSession.shared.dataTask(with: request)
            {
                data, response, error in
                guard response != nil
                else
                {
                   confirmationMessage = "Failed to connect to server. Please check your internet connection."
                    return
                }
                
                guard let data = data
                else
                {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }
                
                if let decodedOrder = try? JSONDecoder().decode(OrderData.self, from: data) {
                    print("Confirmation alert")
                    self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderData.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    self.showingConfirmation = true
                }
                else
                {
                    print("Invalid response from server")
                }
            }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
