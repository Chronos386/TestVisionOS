//
//  AlertsShower.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import SwiftUI

func showAlert(withMessage message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    let topWindow = windowScene.windows.first {
        topWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
