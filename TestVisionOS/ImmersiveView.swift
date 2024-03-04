//
//  ImmersiveView.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
