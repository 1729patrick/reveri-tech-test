//
//  ImagePlaceholder.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ImagePlaceholder: View {
    
    var body: some View {
        ZStack {
            Color.secondary
                .opacity(0.15)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 4)
            ProgressView()
        }
    }
}

struct ImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholder()
    }
}
