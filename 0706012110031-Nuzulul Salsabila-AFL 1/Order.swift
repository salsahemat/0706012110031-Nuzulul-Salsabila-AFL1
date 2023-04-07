//
//  Order.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//

import Foundation

// memberikan template untuk object-object yang dapat digunakan untuk melakukan proses order dalam sebuah sistem pembelian makanan.
protocol OrderProtocol {
    var cafeteria: Cafeteria { get }
    var cartItem: CartItem { get }
    
    func orderScreen() -> CartItem?
}
//implementasi dari protocol OrderProtocol yang mendefinisikan properti dan fungsi yang harus ada pada suatu object Order
class Order: OrderProtocol {
    var cafeteria: Cafeteria
    var cartItem: CartItem
    //menyimpan informasi tentang kantin (cafeteria) dan item belanjaan (cartItem) yang dibeli oleh pelanggan.
    init(cafeteria: Cafeteria, cartItem: CartItem) {
        self.cafeteria = cafeteria
        self.cartItem = cartItem
    }
    //menampilkan prompt untuk meminta input jumlah item belanjaan yang ingin dibeli, kemudian akan membuat objek CartItem baru dengan jumlah belanjaan yang dimasukkan, dan menambahkannya ke dalam objek ShoppingCart.
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
        //mengembalikan objek CartItem yang baru dibuat.
        return cartItem
    }
}


