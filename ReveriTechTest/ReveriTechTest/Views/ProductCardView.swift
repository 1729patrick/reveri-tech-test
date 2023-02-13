//
//  ProductCardView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ProductCardView: View {
    @ObservedObject var product: Product
    var amount: Int
    
    var details: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(product.productTitle)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
                
                if amount > .zero {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text(String(amount))
                                .font(.caption2)
                                .foregroundColor(.white)
                        )
                }
            }
            
            HStack {
                Text(product.currentPriceFormatted)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.accentColor)
                    .lineLimit(1)
                
                Text(product.originalPriceFormatted)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                    .strikethrough()
                    .lineLimit(1)
            }
        }
    }
    
    var body: some View {
        VStack {
            ThumbnailView(url: product.productThumbnail)
                .frame(height: 120)
            
            details
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: Product.example, amount: 0)
    }
}

