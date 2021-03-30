//
//  Order.swift
//  CupcakeCorner
//
//  Created by Derek Santolo on 12/28/20.
//

import Foundation

class Order: Codable, ObservableObject
{
    enum CodingKeys: CodingKey
    {
        case orderData
    }
    
    @Published var orderData: OrderData
        
    init() {
        self.orderData = OrderData()
    } 
    
    required init(from decoder: Decoder) throws
    {
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderData = try container.decode(OrderData.self, forKey: .orderData)
    }
    
    func encode(to encoder: Encoder) throws
    {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderData, forKey: .orderData)
    }
}
    
struct OrderData: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    init() { }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false
    {
        didSet
        {
            if specialRequestEnabled == false
            {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool
    {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
        }
        
        return true
    }
    
    var cost: Double
    {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting
        {
            cost += Double(quantity)
        }
        
        if addSprinkles
        {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

