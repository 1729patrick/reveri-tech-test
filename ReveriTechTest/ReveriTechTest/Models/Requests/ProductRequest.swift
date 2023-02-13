//
//  ProductRequest.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Foundation

struct ProductResponse: Hashable, Codable {
    var id: Int16
    
    var title: String
    var price: Float
    var discountPercentage: Float
    var stock: Int16
    var thumbnail: String
}

struct ProductRequest: Decodable {
    var products: [ProductResponse]
    var total: Int = 0
    
    static var url = "https://dummyjson.com/products"
    
    static var defaultValue: ProductRequest {
        ProductRequest(products: [])
    }
}
