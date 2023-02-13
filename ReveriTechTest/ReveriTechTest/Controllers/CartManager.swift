//
//  CartManager.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var cartProducts: [CartProduct] = []
    
//    To avoid iterating through all products loaded each time a product is added to the cart
    var cartProductsMap = [Product: Int]()
    
    var amount: Int {
        cartProducts.count
    }
    
    var total: Float {
        cartProducts.reduce(into: 0) { total, cartProduct in
            total += Float(cartProduct.amount) * cartProduct.product.currentPrice
        }
    }
    
    func getAmount(product: Product) -> Int {
        cartProductsMap[product] ?? 0
    }
    
    func updateAmount(product: Product, amount: Int) {
        if amount == .zero {
            removeFromCart(product: product)
            return
        }
        
        addToCart(product: product, amount: amount)
    }
    
    func addToCart(product: Product, amount: Int) {
        cartProductsMap[product] = amount
        
        if let cardProductIndex = cartProducts.firstIndex(where: { $0.product == product }) {
            var cartProduct = cartProducts[cardProductIndex]
            cartProduct.amount = amount
            
            cartProducts[cardProductIndex] = cartProduct
            
            return
        }
        
        let cartProduct = CartProduct(product: product, amount: amount)
        cartProducts.append(cartProduct)
    }
    
    func removeFromCart(product: Product) {
        cartProductsMap[product] = 0
        
        cartProducts = cartProducts.filter { $0.product != product }
    }
}
