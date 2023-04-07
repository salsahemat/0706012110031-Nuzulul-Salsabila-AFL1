//
//  Cafeteria.swift
//  0706012110031-Nuzulul Salsabila-AFL 1
//
//  Created by Nuzulul Salsabila on 07/04/23.
//
import Foundation

//memodelkan sebuah kantin (cafeteria) yang memiliki nama dan daftar menu makanan yang disajikan di dalamnya.
struct Cafeteria {
    var name: String
    var menu: [String: Int]
    
    init(name: String, menu: [String: Int]) {
        self.name = name
        self.menu = menu
    }
}

