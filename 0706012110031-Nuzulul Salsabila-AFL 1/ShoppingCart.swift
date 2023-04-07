//
//  ShoppingCart.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//

import Foundation

//blueprint (template) untuk sebuah tipe data yang memiliki satu method calculateTotal() yang mengembalikan nilai bertipe Int.
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
    // menghapus item dari keranjang belanja berdasarkan CartItem yang diinput.
    func removeItem(item: CartItem) {
        if let index = items.firstIndex(where: { $0.menuItem == item.menuItem }) {
            items.remove(at: index)
        }
    }
    //menghitung total harga dari seluruh item yang ada di dalam keranjang belanja (items) pada kelas ShoppingCart.
    func calculateTotal() -> Int {
        var total = 0
        for item in items {
            total += item.calculatePrice()
        }
        return total
    }
}
