//
//  Double+FormatCurrency.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import Foundation

extension Float {
    func formatCurrency(currency: String = "EUR") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
        let result = formatter.string(from: self as NSNumber)!
        
        return result
    }
}
