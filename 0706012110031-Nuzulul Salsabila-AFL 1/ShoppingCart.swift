//
//  ShoppingCart.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//

import Foundation

protocol Checkout {
    func calculateTotal() -> Int
}
// class untuk mengelola keranjang belanja dan melakukan checkout
class ShoppingCart: Checkout {
    var items: [CartItem] = []
    static var saveorder: [String] = []
    static var cartorder: [String: Int] = [:]
    func addItem(item: CartItem) {
        items.append(item)
    }
    
    func removeItem(item: CartItem) {
        if let index = items.firstIndex(where: { $0.menuItem == item.menuItem }) {
            items.remove(at: index)
        }
    }
    
    func calculateTotal() -> Int {
        var total = 0
        for item in items {
            total += item.calculatePrice()
        }
        return total
    }
}
