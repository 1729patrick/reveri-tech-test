//
//  CartButtonView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct CartButtonView: View {
    var amount: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
            
            if amount > .zero {
                Text(String(amount))
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(Color.accentColor)
                    .cornerRadius(40)
                    .offset(x: 10, y: -10)
            }
        }
        .animation(.linear, value: amount)
    }
}

struct CartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CartButtonView(amount: 1)
    }
}
