//
//  ProductsView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @StateObject var viewModel: ViewModel
    
    @State var selectedProduct: Product?
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var grid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
            ForEach(viewModel.products) { product in
                Button {
                    selectedProduct = product
                } label: {
                    ProductCardView(product: product, amount: cartManager.getAmount(product: product))
                }
                .onAppear {
                    if product == viewModel.products.last {
                        viewModel.loadMoreProducts()
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                grid
                
                if !viewModel.fullListLoaded {
                    ProgressView()
                        .padding(.vertical)
                }
            }
            .sheet(isPresented: $viewModel.presentingCart) {
                CartView()
                    .presentationDetents([.fraction(0.9), .large])
            }
            .sheet(item: $selectedProduct) { product in
                ProductDetailView(
                    product: product,
                    amount: cartManager.getAmount(product: product)
                )
                .presentationDetents([.fraction(0.6), .large])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.presentingCart = true
                    } label: {
                        CartButtonView(amount: cartManager.amount)
                    }
                }
            }
            .navigationTitle("Reveri Store")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
    
    init(dataController: DataController, networkController: NetworkController) {
        let viewModel = ViewModel(
            dataController: dataController,
            networkController: networkController
        )
        
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(
            dataController: DataController.preview,
            networkController: NetworkController.preview
        )
    }
}
