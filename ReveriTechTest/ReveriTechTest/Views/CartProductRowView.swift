//
//  CartProductRowView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct CartProductRowView: View {
    @State var amount: Int
    var onChange: (Int) -> Void
    
    var cartProduct: CartProduct
    
    var product: Product {
        cartProduct.product
    }
    
    var totalPrice: String {
        (product.currentPrice * Float(amount)).formatCurrency()
    }
    
    var details: some View {
        VStack(alignment: .leading) {
            Text(product.productTitle)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text(totalPrice)
                .font(.caption)
                .foregroundColor(Color.accentColor)
                .lineLimit(1)
        }
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        HStack {
            AnimatedCounterView(
                amount: $amount,
                lowerBound: 0,
                upperBound: product.productStock
            )
            .onChange(of: amount, perform: onChange)
            
            details
            
            Spacer()
            
            ThumbnailView(url: product.productThumbnail)
                .frame(height: 40)
        }
    }
    
    init(cartProduct: CartProduct, onChange: @escaping (Int) -> Void) {
        self.amount = cartProduct.amount
        self.cartProduct = cartProduct
        
        self.onChange = onChange
    }
}

struct CartProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductRowView(cartProduct: CartProduct.example) { _ in }
    }
}
