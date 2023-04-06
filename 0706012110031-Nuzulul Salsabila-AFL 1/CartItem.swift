//
//  CartItem.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//

import Foundation
class CartItem {
    var menuItem: String
    var itemPrice: Int
    var totalbeli: Int
    var restaurant: String
    
    init(menuItem: String, itemPrice: Int, totalbeli: Int, restaurant: String) {
        self.menuItem = menuItem
        self.itemPrice = itemPrice
        self.totalbeli = totalbeli
        self.restaurant = restaurant
    }
    
    func calculatePrice() -> Int {
        return itemPrice * totalbeli
    }
}
