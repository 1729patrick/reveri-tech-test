//
//  CartView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var cartManager: CartManager
    
    var list: some View {
        List {
            ForEach(cartManager.cartProducts) { cartProduct in
                CartProductRowView(cartProduct: cartProduct) { amount in
                    withAnimation {
                        cartManager.updateAmount(product: cartProduct.product, amount: amount)
                    }
                }
            }
            .onDelete { offsets in
                delete(offsets)
            }
            .listRowSeparator(.hidden)
        }
    }
    
    var empty: some View {
        Text("Your cart is empty! 🙁")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if cartManager.amount > .zero {
                    list
                } else {
                    empty
                }
            }
            
            .listStyle(.plain)
            .navigationTitle("Your cart")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if cartManager.amount > .zero {
                        Button {
                            dismiss()
                        } label: {
                            Text("Checkout (\(cartManager.total.formatCurrency()))")
                        }
                        .buttonStyle(RoundedButtonStyle())
                    }
                }
            }
        }
    }
    
    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let cartProduct = cartManager.cartProducts[offset]
            cartManager.removeFromCart(product: cartProduct.product)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
