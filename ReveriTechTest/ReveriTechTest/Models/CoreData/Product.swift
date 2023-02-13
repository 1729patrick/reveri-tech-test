//
//  Product.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Foundation

extension Product {
    var productTitle: String {
        title ?? ""
    }
    
    var productStock: Int {
        Int(stock)
    }
    
    var productThumbnail: String {
        thumbnail ?? ""
    }
    
    var originalPriceFormatted: String {
        originalPrice.formatCurrency()
    }
    
    var currentPriceFormatted: String {
        currentPrice.formatCurrency()
    }
    
    var originalPrice: Float {
        price
    }
    
    var currentPrice: Float {
        price * (1 - discountPercentage / 100)
    }
    
    static var example: Product {
        let viewContext = DataController.preview.container.viewContext
        
        let product = Product(context: viewContext)
        
        product.stock = 1729
        product.discountPercentage = 10
        product.price = 1499
        product.title = "iPhone 14 Pro Max"
        
        let imageId = Int.random(in: 1...77)
        product.thumbnail = "https://dummyjson.com/image/i/products/\(imageId)/thumbnail.jpg"
        
        return product
    }
}
