//
//  ProductDetailView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var product: Product
    
    @State var amount: Int = .zero
    
    private var initialAmount: Int = .zero
    
    @State private var impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var buttonColor: Color {
        if initialAmount == .zero {
            return Color.accentColor
        }
        
        if initialAmount == amount {
            return Color.red
        }
        
        return Color.green
    }
    
    var buttonLabel: String {
        let totalPrice = (Float(amount) * product.currentPrice).formatCurrency()
        
        if initialAmount == .zero {
            return "Add to cart (\(totalPrice))"
        }
        
        if amount == initialAmount {
            return "Remove all (\(totalPrice))"
        }
        
        return "Update cart (\(totalPrice))"
    }
    
    var details: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(product.currentPriceFormatted)
                    .fontWeight(.medium)
                    .foregroundColor(Color.accentColor)
                
                Text(product.originalPriceFormatted)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .strikethrough()
                
                Spacer()
            }
        }
    }
    
    var bottomBar: some View {
        HStack {
            CounterView(
                amount: $amount,
                lowerBound: 1,
                upperBound: product.productStock
            )
            
            Button {
                addToCart()
            } label: {
                Text(buttonLabel)
            }
            .buttonStyle(RoundedButtonStyle(fill: buttonColor))
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    ThumbnailView(url: product.productThumbnail)
                        .frame(height: 250)
                    
                    details
                }
            }
            .padding(.horizontal)
            .navigationTitle(product.productTitle)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    bottomBar
                }
            }
        }
    }
    
    init(product: Product, amount: Int) {
        self.product = product
        
        self._amount = State(initialValue: max(amount, 1))
        self.initialAmount = amount
    }
    
    func addToCart() {
        dismiss()
        impactFeedback.impactOccurred()
        
        if initialAmount == amount {
            cartManager.removeFromCart(product: product)
            return
        }
        
        cartManager.addToCart(product: product, amount: amount)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.example, amount: 0)
    }
}
