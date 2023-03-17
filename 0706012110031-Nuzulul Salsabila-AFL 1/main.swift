//  main.swift
//  0706012110031-Nuzulul Salsabila-AFL 1

import Foundation
var userinput: String = ""
var cafeteria = [ //membuat dictionary dengan key nama cafeteria valuenya itu dictionary kecil yang memiliki key menu dari resto dengan value harga dari resto
    "Tuku-Tuku": [
        "Tahu isi": 5000,
        "Nasi Kuning": 20000,
        "Nasi Campur": 15000,
        "Air Mineral": 4000
    ],
    "Gotri": [
        "Nasi goreng": 25000,
        "Mie goreng": 20000,
        "Pangsit Goreng": 18000,
        "Es teh": 5000
    ],
    "Madam lie": [
        "Nasi Ayam Geprek": 25000,
        "Nasi Ayam Sayur": 23000,
        "Mie Kuah": 19000,
        "Es jeruk": 8000
    ],
    "Gisoe": [
        "Ice Americano": 24000,
        "Vanilla Latte": 27000,
        "Creamy Klepon": 28000,
        "Donut": 15000
    ],
    "Kopte": [
        "Kopi Tarik Kopte": 15000,
        "Teh Kundur": 16000,
        "Teh Tarik Kopte": 15000,
        "Milo Dinosaur🦖": 16000
    ]
]

var saveorder: [String] = []
var cartorder = [String: Int]()
var totalbeli: Int = 0
var harga: Int = 0
var totalharga: Int = 0
var totalPesanan = 0

func mainScreen(){
        print("\nWelcome to UC-Walk Foodcourt👨🏻‍🍳👨🏻‍🍳 \n" + "Please choose cafeteria: \n")
        print("[1] Tuku-Tuku")
        print("[2] Gotri")
        print("[3] Madam lie")
        print("[4] Gisoe")
        print("[5] Kopte \n" + "-")
        print("[S] Shopping Cart")
        print("[Q] Quit")
        print("Your Choice?",terminator: " ")
        userinput = readLine()!.uppercased()
        
        switch userinput{
        case "1":
            menuTukuTuku()
        case "2":
            menuGotri()
        case "3":
            menuMadamLie()
        case "4":
            menuGisoe()
        case "5":
            menuKopte()
        case "S":
            shoppingcart()
        break
        case "Q":
            exit(0)
        default:
            mainScreen()
        }
    }


func orderScreen(menuItem: String, itemPrice: Int, cafeteriaName: String) {
    print("How many \(menuItem) do you want to buy? ", terminator: " ")
    guard let input = readLine(), let inputTotalbeli = Int(input.trimmingCharacters(in: .whitespaces)), inputTotalbeli > 0 else { // 
        print("Invalid input") // guard memastikan input selau angka positif
        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: cafeteriaName)
        return
    }
    totalbeli = inputTotalbeli
    let harga = itemPrice * totalbeli
    totalharga += harga
    if let existingOrder = cartorder[menuItem] {
        cartorder[menuItem] = existingOrder + totalbeli  // jika item sudah ada di keranjang belanja, tambahkan jumlah pesanan baru ke dalam item yang sudah ada
    } else {
        cartorder[menuItem] = totalbeli  // jika item belum ada di keranjang belanja, tambahkan item baru ke dalam keranjang belanja
    }
    if !saveorder.contains(cafeteriaName) {  // tambahkan nama toko ke dalam saveorder jika belum ada
        saveorder.append(cafeteriaName)
    }
    totalPesanan += totalbeli
    print("Thank you for ordering")
}

func shoppingcart() {
    if cartorder.isEmpty {
        print("Your cart is empty.")
        print("""
              Press [B] to go back
              Your choice?
              """, terminator: " ")
        userinput = readLine()!.lowercased()

        switch userinput {
        case "b":
            mainScreen()
        default:
            shoppingcart()
        }
    } else {
        for shopcart in saveorder {
            print("Your order from \(shopcart):")
            var foundItems = false
            if let restaurant = cafeteria[shopcart] {
                for (item, qty) in cartorder {
                    if restaurant[item] != nil {
                        print("- \(item) x \(qty)")
                        foundItems = true
                    }
                }
            }
            if !foundItems {
                print("You don't have any order from \(shopcart)")
            }
        }
        print("""
              \nPress [B] to go back
              Press [P] to pay / checkout
              Press [C] to cancel your order
              Your choice?
              """, terminator: " ")
        userinput = readLine()!.lowercased()

        print()

        switch userinput {
        case "b":
            mainScreen()
        case "p":
            checkout()
        case "c":
            cartorder.removeAll()
            mainScreen()
        default:
            shoppingcart()
        }
    }
}

func emptyCart() {
    cartorder.removeAll()
    totalharga = 0
}


func checkout() {
    print("Checkout Screen\n")
    print("Your total order: \(totalharga)")
    while true {
        print("Enter the amount of your money:", terminator: " ")

        guard let input = readLine() else {
            print("Please enter your payment.\n")
            continue
        }

        if let payment = Int(input) {
            if payment == 0 {
                print("Payment can't be zero.\n")
                continue
            } else if payment < 0 {
                print("Please enter a valid amount.\n")
                continue
            } else if payment < totalharga {
                print("Please enter a valid amount.\n")
                continue
            }

            let change = payment - totalharga
            print("""
            Your total order: \(totalharga)
            You pay: \(payment)
            Change: \(change)
            \nEnjoy your meals!

            Press [return] to go back to main screen:
            """, terminator: " ")
            userinput = readLine()!.uppercased()
            emptyCart()
            mainScreen()

            // keluar dari loop while
            break
        } else {
            print("Please enter a valid amount.")
            continue
        }
    }
}




//TUKU-TUKU
func menuTukuTuku() {
    print("""
    \nHi, Welcome back to Tuku-Tuku!
    What would you like to order?
    """)
    
    for (index, menu) in cafeteria["Tuku-Tuku"]!.enumerated() {
        let menuItem = menu.key
        print("[\(index+1)] \(menuItem)")
    }
   print("""
    -
    [B]ack to Main Menu
    Your Menu Choice?
    """, terminator: " ")
    let userinput = readLine()!.lowercased()

    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= cafeteria["Tuku-Tuku"]!.count else {
            print("Invalid input")
            print("Invalid input")
            menuTukuTuku()
            return
        }
        let menuItem = Array(cafeteria["Tuku-Tuku"]!.keys)[index - 1]
        let itemPrice = Array(cafeteria["Tuku-Tuku"]!.values)[index - 1]
        print("\n\(menuItem) @ \(itemPrice)")
        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Tuku-Tuku")
        menuTukuTuku()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuTukuTuku()
    }
}

//GOTRI
func menuGotri() {
    print("""
        \nHi, Welcome back to Gotri!
        What would you like to order?
        """)
    
    for (index, menu) in cafeteria["Gotri"]!.enumerated() {
        let menuItem = menu.key
//        let itemPrice = menu.value
        print("[\(index+1)] \(menuItem)")
    }
    print("""
        -
        [B]ack to Main Menu
        Your Menu Choice?
        """, terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= cafeteria["Gotri"]!.count else {
            print("Invalid input")
            menuGotri()
            return
        }
        let menuItem = Array(cafeteria["Gotri"]!.keys)[index - 1]
        let itemPrice = Array(cafeteria["Gotri"]!.values)[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Gotri")

        menuGotri()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuGotri()
    }
}

//MADAM LIE
func menuMadamLie(){
    print("""
    \nHi, Welcome back to Madam Lie!
    What would you like to order?
   """)
    
    for (index, menu) in cafeteria["Madam lie"]!.enumerated() {
        let menuItem = menu.key
//        let itemPrice = menu.value
        print("[\(index+1)] \(menuItem)")
    }
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= cafeteria["Madam lie"]!.count else {
            print("Invalid input")
            menuMadamLie()
            return
        }
        let menuItem = Array(cafeteria["Madam lie"]!.keys)[index - 1]
        let itemPrice = Array(cafeteria["Madam lie"]!.values)[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Madam lie") // panggil fungsi orderScreen() dengan argumen index

        menuMadamLie()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuMadamLie()
    }
}

func menuGisoe(){
    print("""
    \nHi, Welcome to Gisoe Cafe!
    What would you like to order?
   """)
    
    for (index, menu) in cafeteria["Gisoe"]!.enumerated() {
        let menuItem = menu.key
//        let itemPrice = menu.value
        print("[\(index+1)] \(menuItem)")
    }
    
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= cafeteria["Gisoe"]!.count else {
            print("Invalid input")
            menuGisoe()
            return
        }
        let menuItem = Array(cafeteria["Gisoe"]!.keys)[index - 1]
        let itemPrice = Array(cafeteria["Gisoe"]!.values)[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Gisoe") // panggil fungsi orderScreen() dengan argumen index

        menuGisoe()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuGisoe()
    }
}

func menuKopte() {
    print("""
    \nHi, Welcome to Kopte Cafe!
    What would you like to order?
   """)
    
    for (index, menu) in cafeteria["Kopte"]!.enumerated() {
        let menuItem = menu.key
//        let itemPrice = menu.value
        print("[\(index+1)] \(menuItem)")
    }
    
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= cafeteria["Kopte"]!.count else {
            print("Invalid input")
            menuKopte()
            return
        }
        let menuItem = Array(cafeteria["Kopte"]!.keys)[index - 1]
        let itemPrice = Array(cafeteria["Kopte"]!.values)[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Kopte") // panggil fungsi orderScreen() dengan argumen index

        menuKopte()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuKopte()
    }
}
mainScreen()
