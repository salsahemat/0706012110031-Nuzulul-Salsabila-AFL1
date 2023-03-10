//  main.swift
//  0706012110031-Nuzulul Salsabila-AFL 1

import Foundation
var userinput: String = ""
var cafeteria = ["Tuku-Tuku","Gotri","Madam lie","Gisoe", "Kopte"]
var menutukutuku = ["Tahu isi","Nasi Kuning","Nasi Campur","Air Mineral"]
var hargatuku = [5000,20000,15000,4000]
var menugotri = ["Nasi goreng","Mie goreng","Pangsit Goreng","Es teh"]
var hargagotri = [25000,20000,18000,5000]
var menumadamlie = ["Nasi Ayam geprek","Nasi ayam sayur","Mie Kuah","Es jeruk"]
var hargamadamlie = [25000,23000,19000,8000]
var menugisoe = ["Ice Americano","Vanilla latte","Creamy Klepon","Donut"]
var hargagisoe = [24000,27000,28000,15000]
var menukopte = ["Kopi tarik kopte","Teh Kundur","Teh tarik kopte","Milo Dinosaur🦖"]
var hargakopte = [15000,16000,15000,16000]
var item_tukutuku: [String] = []
var item_gotri: [String] = []
var item_madamlie: [String] = []
var item_gisoe: [String] = []
var item_kopte: [String] = []
var saveorder: [String] = []
var cartorder:[String] = []
var totalbeli: Int = 0
var harga: Int = 0
var totalharga: Int = 0
let milih = Int(userinput) ?? 0
var totalPesanan = 0
var dupe = false

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
    guard let input = readLine(), let inputTotalbeli = Int(input), inputTotalbeli > 0 else {
        print("Invalid input")
        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: cafeteriaName)
        return
    }
    totalbeli = inputTotalbeli
    print("You have ordered \(totalbeli) \(menuItem) @ \(itemPrice) each from \(cafeteriaName)")
    let harga = itemPrice * totalbeli
    totalharga += harga
    cartorder.append("\(menuItem) x \(totalbeli)")
    saveorder.append(cafeteriaName)
    totalPesanan += totalbeli // menambahkan pesanan baru ke totalPesanan
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
        if cartorder.count == saveorder.count {
            for (index, shopcart) in saveorder.enumerated() {
                print("Your order from \(shopcart):")
                print("- \(cartorder[index])")
            }
        } else {
            print("Error: Your cart and saved order don't match.")
        }
        
        print("""
              Press [B] to go back
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


func checkout() {
    print("""
    \nCheckout Screen
    Total order: \(totalharga)
    Total Items: \(totalbeli)
    Enter the amount of your money:
    """, terminator: " ")

    guard let input = readLine() else {
        print("Please enter your payment.")
        checkout()
        return
    }

    if let payment = Int(input) {
        if payment == 0 {
            print("Payment can't be zero.")
            checkout()
            return
        } else if payment < 0 {
            print("Please enter a valid amount.")
            checkout()
            return
        } else if payment < totalharga {
            print("Please enter a valid amount.")
            checkout()
            return
        }
        let change = payment - totalharga
        print("""
        Total Payment: \(payment)
        Change: \(change)
        Thank you for your purchase!
        """)
        exit(0)
    } else {
        print("Please enter a valid amount.")
        checkout()
        return
    }
}




//TUKU-TUKU
func menuTukuTuku() {
    var check = false
    print("""
    \nHi, Welcome back to Tuku-Tuku!
    What would you like to order?
    """)
    
    for (index, menu) in menutukutuku.enumerated() {
        print("[\(index+1)] \(menu)")
    }
   print("""
    -
    [B]ack to Main Menu
    Your Menu Choice?
    """, terminator: " ")
    let userinput = readLine()!.lowercased()

    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= menutukutuku.count else {
            print("Invalid input")
            menuTukuTuku()
            return
        }
        let menuItem = menutukutuku[index - 1]
        let itemPrice = hargatuku[index - 1]
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
    
    for (index, menu) in menugotri.enumerated() {
        print("[\(index+1)] \(menu)")
    }
    
    print("""
        -
        [B]ack to Main Menu
        Your Menu Choice?
        """, terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= menugotri.count else {
            print("Invalid input")
            menuGotri()
            return
        }
        let menuItem = menugotri[index - 1]
        let itemPrice = hargagotri[index - 1]

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
    for (index, menu) in menumadamlie.enumerated() {
        print("[\(index+1)] \(menu)")
    }
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= menumadamlie.count else {
            print("Invalid input")
            menuMadamLie()
            return
        }
        let menuItem = menumadamlie[index - 1]
        let itemPrice = hargamadamlie[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Madam Lie") // panggil fungsi orderScreen() dengan argumen index

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
    
    for (index, menu) in menugisoe.enumerated() {
        print("[\(index+1)] \(menu)")
    }
    
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= menugisoe.count else {
            print("Invalid input")
            menuGisoe()
            return
        }
        let menuItem = menugisoe[index - 1]
        let itemPrice = hargagisoe[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice, cafeteriaName: "Gisoe") // panggil fungsi orderScreen() dengan argumen index

        menuGisoe()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuGisoe()
    }
}

func menuKopte(){
    print("""
    \nHi, Welcome to Kopte Cafe!
    What would you like to order?
   """)
    
    for (index, menu) in menukopte.enumerated() {
        print("[\(index+1)] \(menu)")
    }
    
    print("""
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased()
    
    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput), index <= menukopte.count else {
            print("Invalid input")
            menuKopte()
            return
        }
        let menuItem = menukopte[index - 1]
        let itemPrice = hargakopte[index - 1]

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
