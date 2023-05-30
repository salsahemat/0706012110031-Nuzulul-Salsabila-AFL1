//
//  main.swift
//
//  Created by Nuzulul Salsabila on 06/04/23.
//
import Foundation

class Main {
    //cafeterias merupakan array dari objek Cafeteria, di mana setiap objek Cafeteria memiliki sebuah dictionary sebagai atribut menu-nya.
    var cafeterias = [
        Cafeteria(name: "Tuku-Tuku", menu: ["Tahu isi": 5000, "Nasi Kuning": 20000, "Nasi Campur": 15000,"Air Mineral": 4000]),
        Cafeteria(name: "Gotri", menu: ["Nasi goreng": 25000, "Mie goreng": 20000, "Pangsit Goreng": 18000,"Es teh": 5000]),
        Cafeteria(name: "Madam lie", menu: ["Nasi Ayam Geprek": 25000,"Nasi Ayam Sayur": 23000,"Mie Kuah": 19000,"Es jeruk": 8000]),
        Cafeteria(name: "Gisoe", menu: ["Ice Americano": 24000,"Vanilla Latte": 27000,"Creamy Klepon": 28000,"Donut": 15000]),
        Cafeteria(name: "Kopte", menu: ["Kopi Tarik Kopte": 15000,"Teh Kundur": 16000,"Teh Tarik Kopte": 15000,"Milo Dinosaur🦖": 16000])
    ]
    var shoppingCart = ShoppingCart() // merepresentasikan keranjang belanjaan, awalnya kosong.
    var userinput:String = ""
   
    // function untuk menampilkan halaman utama m/ main menu
    func showMainScreen() {
        print("Welcome to UC-Walk Foodcourt👨🏻‍🍳👨🏻‍🍳")
        print("Please choose cafeteria:")
        for (index, cafeteria) in cafeterias.enumerated() {
            print("[\(index + 1)] \(cafeteria.name)")
        }
        print("-")
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
//    memilih kafetaria yang ingin dilihat menu makanannya, dan akan menampilkan menu kafetaria tersebut jika input pengguna    valid.
            if let index = Int(input), index > 0, index <= cafeterias.count {
                let cafeteria = cafeterias[index - 1]
                showCafeteriaMenu(cafeteria: cafeteria)
            } else {
                print("Invalid input")
                showMainScreen()
            }
        }
    }
    //menampilkan isi keranjang belanja dan memberikan beberapa opsi untuk melanjutkan proses belanja atau keluar dari program.
    func showShoppingCart() {
        if shoppingCart.items.isEmpty { // mengecek apakah array items pada objek shoppingCart kosong atau tidak. Jika benar, maka blok kode di dalamnya akan dieksekusi.
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
            // membuat sebuah kamus (dictionary) untuk menyimpan barang-barang yang dikelompokkan berdasarkan restoran.
            var restaurantDict = [String: [CartItem]]()
            for item in shoppingCart.items { // mengelompokkan barang-barang dalam shoppingCart berdasarkan restoran.
                if restaurantDict[item.restaurant] == nil {
                    restaurantDict[item.restaurant] = [item]
                } else {
                    restaurantDict[item.restaurant]?.append(item) // menambahkan item ke dalam array nilai kunci yang sesuai dalam kamus restaurantDict
                }
            }
            
            print("Shopping Cart:")
            // melakukan perulangan untuk setiap restoran dan cetak barang-barang (items) yang dimilikinya.
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
                showShoppingCart()
            default:
                showShoppingCart()
            }
        }
    }

    // menampilkan daftar menu dari suatu kafetaria dan meminta pengguna untuk memilih menu yang ingin dipesan.
    func showCafeteriaMenu(cafeteria: Cafeteria) {
        print("""
        \nHi, Welcome to \(cafeteria.name)!
        What would you like to order?
        """)
        // menampilkan setiap item pada menu kantin beserta nomor urutannya
        for (index, menu) in cafeteria.menu.enumerated() {
            let menuItem = menu.key
            print("[\(index+1)] \(menuItem)")
        }
        print("""
        -
        [B] Back to Main Screen
        Your Choice?
        """, terminator: " ")
        //Input pengguna akan di-parse sebagai bilangan bulat, dan program akan kembali ke menu utama jika input tidak valid atau jika pengguna memilih opsi kembali.
        guard let userInput = readLine(), let menuItemIndex = Int(userInput.trimmingCharacters(in: .whitespaces)), menuItemIndex != 0 else {
            showMainScreen()
            return
        }
        //memeriksa apakah indeks yang dimasukkan oleh pengguna valid atau tidak.
        guard menuItemIndex <= cafeteria.menu.count else {
            print("Invalid input")
            showCafeteriaMenu(cafeteria: cafeteria)
            return
        }
        // mengambil nilai kunci dan nilai dari dictionary yang dipilih oleh pengguna menggunakan menuItemIndex
        let menuItem = Array(cafeteria.menu.keys)[menuItemIndex - 1]
        let itemPrice = Array(cafeteria.menu.values)[menuItemIndex - 1]
        print("\n\(menuItem) @ \(itemPrice)")
        //dan kemudian membuat objek CartItem baru dengan detail item yang dipilih dan menambahkannya ke keranjang belanja dengan memanggil shoppingCart.addItem()
        let orderItem = CartItem(menuItem: menuItem, itemPrice: itemPrice, totalbeli: 1, restaurant: cafeteria.name)
        let order = Order(cafeteria: cafeteria, cartItem: orderItem)
        let orderScreen = order.orderScreen()
        shoppingCart.addItem(item: orderScreen!)

        showCafeteriaMenu(cafeteria: cafeteria)
    }

    
    // melakukan checkout pada keranjang belanja.
    func checkout() {
        //memeriksa apakah keranjang belanja memiliki item. Jika tidak, maka akan mencetak pesan "Your shopping cart is empty" dan kembali ke layar utama.
        guard shoppingCart.items.count > 0 else {
            print("Your shopping cart is empty")
            showMainScreen()
            return
        }
        //Jika ada item di keranjang belanja, fungsi akan mencetak daftar item dan harga.
        print("Checkout:")
        var total = 0
        for item in shoppingCart.items {
            let subtotal = item.calculatePrice()
            print("\(item.menuItem): Rp.\(subtotal)")
            total += subtotal
        }
        print("Total: Rp.\(total)")

        repeat {
            //memasukkan jumlah pembayaran atau memilih kembali ke layar utama.
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
//memanggil fungsi showMainScreen() yang terdapat di kelas Main, yang kemudian menampilkan tampilan utama program
let main = Main()
main.showMainScreen()
