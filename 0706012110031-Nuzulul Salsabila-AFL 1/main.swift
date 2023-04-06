//
//  main.swift
//
//  Created by Nuzulul Salsabila on 06/04/23.
//
import Foundation

class Main {
    var cafeterias = [
        Cafeteria(name: "Tuku-Tuku", menu: ["Tahu isi": 5000, "Nasi Kuning": 20000, "Nasi Campur": 15000,"Air Mineral": 4000]),
        Cafeteria(name: "Gotri", menu: ["Nasi goreng": 25000, "Mie goreng": 20000, "Pangsit Goreng": 18000,"Es teh": 5000]),
        Cafeteria(name: "Madam lie", menu: ["Nasi Ayam Geprek": 25000,"Nasi Ayam Sayur": 23000,"Mie Kuah": 19000,"Es jeruk": 8000]),
        Cafeteria(name: "Gisoe", menu: ["Ice Americano": 24000,"Vanilla Latte": 27000,"Creamy Klepon": 28000,"Donut": 15000]),
        Cafeteria(name: "Kopte", menu: ["Kopi Tarik Kopte": 15000,"Teh Kundur": 16000,"Teh Tarik Kopte": 15000,"Milo Dinosaur🦖": 16000])
    ]
    var shoppingCart = ShoppingCart()
    var userinput:String = ""
   
    func showMainScreen() {
        print("Welcome to UC-Walk Foodcourt👨🏻‍🍳👨🏻‍🍳")
        print("Please choose cafeteria:")
        for (index, cafeteria) in cafeterias.enumerated() {
            print("[\(index + 1)] \(cafeteria.name)")
        }
        print("[S] Shopping Cart")
        print("[Q] Quit")
        print("Your Choice?", terminator: " ")
        
        guard let input = readLine()?.uppercased() else {
            print("Invalid input")
            showMainScreen()
            return
        }
        
        switch input {
        case "Q":
            exit(0)
        case "S":
            showShoppingCart()
        default:
            if let index = Int(input), index > 0, index <= cafeterias.count {
                let cafeteria = cafeterias[index - 1]
                showCafeteriaMenu(cafeteria: cafeteria)
            } else {
                print("Invalid input")
                showMainScreen()
            }
        }
    }
    
    func showShoppingCart() {
        if shoppingCart.items.isEmpty {
            print("Your shopping cart is empty")
            print("""
                  Press [B] to go back
                  Your choice?
                  """, terminator: " ")
            userinput = readLine()!.lowercased()

            switch userinput {
            case "b":
                showMainScreen()
            default:
                showShoppingCart()
            }
        } else {
            // Create a dictionary to store items grouped by restaurant
            var restaurantDict = [String: [CartItem]]()
            for item in shoppingCart.items {
                if restaurantDict[item.restaurant] == nil {
                    restaurantDict[item.restaurant] = [item]
                } else {
                    restaurantDict[item.restaurant]?.append(item)
                }
            }
            
            print("Shopping Cart:")
            // Loop through each restaurant and print its items
            for (restaurant, items) in restaurantDict {
                print("Your order from \(restaurant):")
                for item in items {
                    print("- \(item.menuItem) x \(item.totalbeli)")
                }
            }

            print("""
                  \nPress [B] to go back
                  Press [P] to pay / checkout
                  Press [C] to cancel your order
                  Your choice?
                  """, terminator: " ")
            userinput = readLine()!.lowercased()

            switch userinput {
            case "b":
                showMainScreen()
            case "p":
                checkout()
            case "c":
                emptyCart()
                showMainScreen()
            default:
                showShoppingCart()
            }
        }
    }

    
    func showCafeteriaMenu(cafeteria: Cafeteria) {
        print("""
        \nHi, Welcome to \(cafeteria.name)!
        What would you like to order?
        """)

        for (index, menu) in cafeteria.menu.enumerated() {
            let menuItem = menu.key
            print("[\(index+1)] \(menuItem)")
        }
        print("""
        -
        [B] Back to Main Screen
        Your Choice?
        """, terminator: " ")

        guard let userInput = readLine(), let menuItemIndex = Int(userInput.trimmingCharacters(in: .whitespaces)), menuItemIndex != 0 else {
            showMainScreen()
            return
        }

        guard menuItemIndex <= cafeteria.menu.count else {
            print("Invalid input")
            showCafeteriaMenu(cafeteria: cafeteria)
            return
        }

        let menuItem = Array(cafeteria.menu.keys)[menuItemIndex - 1]
        let itemPrice = Array(cafeteria.menu.values)[menuItemIndex - 1]
        print("\n\(menuItem) @ \(itemPrice)")

        let orderItem = CartItem(menuItem: menuItem, itemPrice: itemPrice, totalbeli: 1, restaurant: cafeteria.name)
        let order = Order(cafeteria: cafeteria, cartItem: orderItem)
        let orderScreen = order.orderScreen()
        shoppingCart.addItem(item: orderScreen!)

        showCafeteriaMenu(cafeteria: cafeteria)
    }

    
    // function to checkout
    func checkout() {
        guard shoppingCart.items.count > 0 else {
            print("Your shopping cart is empty")
            showMainScreen()
            return
        }

        print("Checkout:")
        for item in shoppingCart.items {
            print("\(item.menuItem): Rp.\(item.itemPrice)")
        }
        repeat {
            print("Enter payment amount or [B] to back:", terminator: " ")
            guard let input = readLine()?.uppercased() else {
                print("Invalid input")
                continue
            }
            
            if input == "B" {
                showMainScreen()
                return
            }
            
            guard let payment = Int(input) else {
                print("Invalid input")
                continue
            }
            
            if payment == 0 {
                print("Payment can't be zero.")
                continue
            } else if payment < 0 {
                print("Please enter a valid amount.")
                continue
            } else if payment < shoppingCart.calculateTotal() {
                print("Please enter a valid amount.")
                continue
            }

            let change = payment - shoppingCart.calculateTotal()
            print("""
                Your total order: \(shoppingCart.calculateTotal())
                You pay: \(payment)
                Change: \(change)

                Enjoy your meals!
                
                """)
            
            // kosongkan cart
            emptyCart()
            // kembali ke menu utama
            showMainScreen()
            return
            
        } while userinput != "B"
    }

    func emptyCart() {
        shoppingCart.items.removeAll()
    }
}
let main = Main()
main.showMainScreen()
