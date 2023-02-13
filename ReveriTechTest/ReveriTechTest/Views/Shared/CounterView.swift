//
//  CounterView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct CounterView: View {
    @State private var impactFeedback = UIImpactFeedbackGenerator(style: .light)
    
    @Binding var amount: Int
    
    var lowerBound: Int? = .zero
    var upperBound: Int?
    
    var body: some View {
        HStack {
            Button {
                decrease()
            } label: {
                Circle()
                    .fill(.background)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Image(systemName: "minus")
                            .imageScale(.small)
                    )
            }
            
            Text(String(amount))
                .frame(minWidth: 20)
                .padding(.horizontal, 8)
                .foregroundColor(.white)
            
            Button {
                increase()
            } label: {
                Circle()
                    .fill(.background)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Image(systemName: "plus")
                            .imageScale(.small)
                    )
            }
        }
        .padding(.vertical, 8)
        .frame(height: 50)
        .background(Color.accentColor)
        .cornerRadius(10)
    }
    
    func decrease() {
        if let limit = lowerBound {
            guard amount > limit else {
                return
            }
        }
        
        impactFeedback.impactOccurred()
        amount -= 1
    }
    
    func increase() {
        if let limit = upperBound {
            guard amount < limit else {
                return
            }
        }
        
        
        impactFeedback.impactOccurred()
        amount += 1
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(amount: .constant(0))
    }
}
