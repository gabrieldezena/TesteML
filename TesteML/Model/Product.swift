//
//  Product.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 08/02/21.
//

import Foundation

struct ProductList: Codable {
    let results: [Product]
}

struct Product: Codable {
    let title: String
    let price: Double
    let available_quantity: Int
    let sold_quantity: Int
    let condition: String
    let thumbnail: String
    let buying_mode: String
    let seller: Seller
    let shipping: Shipping
}

struct Seller: Codable {
    let permalink: String
    
}

struct Shipping: Codable {
    let free_shipping: Bool
}
