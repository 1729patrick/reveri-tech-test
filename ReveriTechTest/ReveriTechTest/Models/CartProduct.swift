//
//  CartProduct.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Foundation

struct CartProduct: Identifiable {
    var id: Product {
        product
    }
    
    var product: Product
    var amount: Int
    
    static var example: CartProduct {
        CartProduct(product: Product.example, amount: 7)
    }
}
