//
//  ProductViewModel.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 08/02/21.
//

import UIKit

class ProductViewModel {

    var product: Product

    init(product: Product) {
        self.product = product
    }

    lazy var title: String = {
        let title = product.title
        return title
    }()

    lazy var price: String = {
        let priceStr = String(format: "%.2f", product.price).replacingOccurrences(of: ".", with: ",")
        let price = String(format: "R$%@", priceStr)
        return price
    }()
    
    lazy var available_quantity: Int = {
        let available_quantity = product.available_quantity
        return available_quantity
    }()
    
    lazy var sold_quantity: Int = {
        let sold_quantity = product.sold_quantity
        return sold_quantity
    }()

    lazy var condition: String = {
        switch product.condition {
        case "new":
            return "Novo"
        case "used":
            return "Usado"
        default:
            return "Novo"
        }
    }()

    lazy var thumbnail: String = {
        let thumbnail = product.thumbnail
        return thumbnail
    }()

    lazy var buying_mode: String = {
        let buying_mode = product.buying_mode
        return buying_mode
    }()

    lazy var seller: String = {
        if let seller = product.seller.permalink.split(separator: "/", omittingEmptySubsequences: false).last {
            let sellerName = seller.replacingOccurrences(of: "+", with: " ")
            return String(sellerName)
        }
        return String()
    }()

    lazy var shipping: String = {
        if product.shipping.free_shipping {
            return "Frete Grátis"
        }
        return String()
    }()
}
