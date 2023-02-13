//
//  RoundedButtonStyle.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    var cornerRadius: CGFloat = 10
    var fill: Color = Color.accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .font(.headline.bold())
            .frame(maxWidth: .infinity)
            .foregroundColor(.white.opacity(isEnabled ? 1: 0.5))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(fill)
                    .animation(.linear, value: fill)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.3), value: isEnabled)
    }
}

