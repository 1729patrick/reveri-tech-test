//
//  ProductsViewModel.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import CoreData
import Foundation

extension ProductsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var limit: Int = 20
        
        @Published private var page: Int = .zero
        @Published private var totalListRecords: Int = .zero
        @Published var presentingCart: Bool = false
        
        @Published private(set) var fullListLoaded: Bool = false
        @Published private(set) var products = [Product]()
        
        let networkController: NetworkController
        let dataController: DataController
        
        private let productController: NSFetchedResultsController<Product>
        
        init(dataController: DataController, networkController: NetworkController) {
            self.dataController = dataController
            self.networkController = networkController
            
            
            let productRequest: NSFetchRequest<Product> = Product.fetchRequest()
            productRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Product.id, ascending: true)
            ]
            
            productController = NSFetchedResultsController(
                fetchRequest: productRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            super.init()
            
            productController.delegate = self
            
            do {
                try productController.performFetch()
                products = productController.fetchedObjects ?? []
            } catch {
                
            }
        }
        
        func fetchProducts(skip: Int = 0) {
            let url = URL(string: ProductRequest.url)!
                .appending("limit", value: String(limit))
                .appending("skip", value: String(skip))
            
            networkController.fetch(url, defaultValue: ProductRequest.defaultValue) { response in
                switch response {
                case .success(let response):
                    print("self.page", self.page, skip)
                    // Delete stored products if the app is able to load the first page
                    if response.products.count > .zero && self.page == .zero {
                        self.dataController.deleteAll()
                    }
                    
                    for productResponse in response.products {
                        let product = Product(context: self.dataController.container.viewContext)
                        
                        product.id = productResponse.id
                        product.title = productResponse.title
                        product.thumbnail = productResponse.thumbnail
                        product.price = productResponse.price
                        product.discountPercentage = productResponse.discountPercentage
                        product.stock = productResponse.stock
                    }
                    
                    self.totalListRecords = response.total
                    self.dataController.save()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func loadMoreProducts() {
            page += 1
            fetchProducts(skip: limit * page)
        }
        
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            products = productController.fetchedObjects ?? []
            
            self.fullListLoaded = self.products.count == totalListRecords
        }
    }
}
