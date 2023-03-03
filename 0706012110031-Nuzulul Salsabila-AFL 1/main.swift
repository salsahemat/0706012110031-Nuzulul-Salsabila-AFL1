//  main.swift
//  0706012110031-Nuzulul Salsabila-AFL 1

import Foundation
var userinput: String = ""
var cafeteria = ["Tuku-Tuku","Gotri","Madam lie","Gisoe", "Kopte"]
var menutukutuku = ["Tahu isi","Nasi Kuning","Nasi Campur","Air Mineral"]
var hargatuku = [5000,20000,15000,40000]
var menugotri = ["Nasi goreng","Mie goreng","Pangsit Goreng","Es teh"]
var menumadamlie = ["Nasi Ayam geprek","Nasi ayam sayur","Mie Kuah","Es jeruk"]
var menugisoe = ["Ice Americano","Matcha latte","Asian dolce latte","Donut"]
var menukopte = ["Tahu isi","Nasi Kuning","Nasi Campur","Air Mineral"]
var saveorder: [String] = []
var cartorder:[String] = []
var totalbeli: Int = 0
var harga: Int = 0
var totalharga: Int = 0
let milih = Int(userinput) ?? 0

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


func menuTukuTuku() {
    print("""
    \nHi, Welcome back to Tuku-Tuku!
    What would you like to order?
    [1] Tahu isi
    [2] Nasi Kuning
    [3] Nasi Campur
    [4] Air Mineral
    -
    [B]ack to Main Menu
    Your Menu Choice?
    """, terminator: " ")
    userinput = readLine()!.lowercased()

    switch userinput {
    case "1"..."4":
        guard let index = Int(userinput) else {
            print("Invalid input")
            menuTukuTuku()
            return
        }
        let menuItem = menutukutuku[index - 1]
        let itemPrice = hargatuku[index - 1]

        orderScreen(menuItem: menuItem, itemPrice: itemPrice) // panggil fungsi orderScreen() dengan argumen index
//
//        print("\(menuItem) @ \(itemPrice) \nThank you for ordering")
//        cartorder.append("\(menuItem) x \(totalbeli)")
//        saveorder.append("Tuku-Tuku")
//
//        let harga = itemPrice * totalbeli
//        totalharga += harga
        menuTukuTuku()
    case "b":
        mainScreen()
    default:
        print("Invalid input")
        menuTukuTuku()
    }
}



func orderScreen(menuItem: String, itemPrice: Int) {
    print("How many \(menuItem) do you want to buy? ", terminator: " ")
    guard let input = readLine(), let inputTotalbeli = Int(input), inputTotalbeli > 0 else {
        print("Invalid input")
        orderScreen(menuItem: menuItem, itemPrice: itemPrice)
        return
    }
    totalbeli = inputTotalbeli
    print("You have ordered \(totalbeli) \(menuItem) @ \(itemPrice) each")
    let harga = itemPrice * totalbeli
    totalharga += harga
    cartorder.append("\(menuItem) x \(totalbeli)")
    saveorder.append("Tuku-Tuku")
    print("Thank you for ordering")
}



func shoppingcart(){
    if cartorder.isEmpty{
        print("Your cart is empty.")
    }
    else{
        for(index, shopcart) in saveorder.enumerated(){
            print("Your order from \(shopcart) :")
            print("- \(cartorder[index])")
        }
        print("""
              Press [B] to go back
              Press [P] to pay / checkout
              Your choice?
              """, terminator: " ")
        userinput = readLine()!.lowercased()
        
        print()
        
        switch userinput{
        case "b" :
            mainScreen()
            
        case "p" :
           checkout()
            
        default :
            shoppingcart()
        }
    }

}

func checkout() {
    print("""
    \nCheckout Screen
    Total order: \(totalharga)
    Input your payment amount:
    """, terminator: " ")

    guard let input = readLine(), let payment = Int(input), payment >= totalharga, payment > 0 else {
        print("Invalid input, please try again")
        checkout()
        return
    }

    let change = payment - totalharga
    print("""
    Total Payment: \(payment)
    Change: \(change)
    Thank you for your purchase!
    enjoy your meals!
    Press [return] to go back to main screen👋🏼:
    """)
    _ = readLine()
    mainScreen()
    
    // Reset totalharga
    totalharga = 0
}



func menuGotri(){
    print("""
    Hi, Welcome back to Gotri!
    What would you like to order?
    [1] Nasi Goreng
    [2] Mie Goreng
    [3] Pangsit goreng
    [4] Es teh
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased().uppercased()
}

func menuMadamLie(){
    print("""
    Hi, Welcome back to Madam Lie!
    What would you like to order?
    [1] Ayam geprek
    [2] Nasi ayam sayur
    [3] Mie kuah
    [4] Air Mineral
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased().uppercased()
    
}

func menuGisoe(){
    print("""
    Hi, Welcome to Gisoe Cafe!
    What would you like to order?
    [1] Ice Americano
    [2] Matcha Latte
    [3] Asian dolce latte
    [4] Donut
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased().uppercased()
}

func menuKopte(){
    print("""
    Hi, Welcome to Kopte Cafe!
    What would you like to order?
    [1] Kopi Tarik Kopte
    [2] Teh Tarik Kopte
    [3] Coklat tarik
    [4] Teh Jeruk Nipis
    -
    [B] ack to Main Menu
    Your Menu Choice?
    """,terminator: " ")
    userinput = readLine()!.lowercased().uppercased()

}



mainScreen()





