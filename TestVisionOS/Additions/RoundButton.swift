//
//  RoundButton.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import SwiftUI

struct RoundButton: ViewModifier {
    private let color: Color
    private let processingState: Bool
    
    init(_ isProcessing: Bool, color: Color) {
        processingState = isProcessing
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .font(Font.callout.bold())
                .foregroundColor(Color.white)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                .padding(10)
                .background(self.color)
                .cornerRadius(8)
                .opacity(processingState ? 0.5 : 1)
            if processingState {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }
        }
        .contentShape(Rectangle())
    }
}

extension View {
    func roundButton(_ processingState: Bool = false, color: Color = .blue) -> some View {
        ModifiedContent(content: self, modifier: RoundButton(processingState, color: color))
    }
}
