//
//  ContentView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataController = DataController()
    @ObservedObject var networkController = NetworkController()
    
    @ObservedObject var cartManager = CartManager()
    
    var body: some View {
        ProductsView(
            dataController: dataController,
            networkController: networkController
        )
        .environmentObject(cartManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
