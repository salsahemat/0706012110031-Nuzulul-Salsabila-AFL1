//
//  Order.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//

import Foundation
protocol OrderProtocol {
    var cafeteria: Cafeteria { get }
    var cartItem: CartItem { get }
    
    func orderScreen() -> CartItem?
}
class Order: OrderProtocol {
    var cafeteria: Cafeteria
    var cartItem: CartItem
    
    init(cafeteria: Cafeteria, cartItem: CartItem) {
        self.cafeteria = cafeteria
        self.cartItem = cartItem
    }
    
    func orderScreen() -> CartItem? {
        print("How many \(cartItem.menuItem) do you want to buy? ", terminator: " ")
        guard let input = readLine(),
              let inputTotalbeli = Int(input.trimmingCharacters(in: .whitespaces)),
              inputTotalbeli > 0 else {
            print("Invalid input")
            return nil
        }
        
        let totalBeli = inputTotalbeli
        _ = cartItem.itemPrice * totalBeli
        
        let cart = ShoppingCart()
        cart.addItem(item: cartItem)
        
        let cartItem = CartItem(menuItem: cartItem.menuItem, itemPrice: cartItem.itemPrice, totalbeli: totalBeli, restaurant: cafeteria.name)
        cart.addItem(item: cartItem)
        print("Thank you for ordering")
        return cartItem
    }
}


