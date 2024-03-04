//
//  TestVisionOSApp.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import SwiftUI

@main
struct TestVisionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
