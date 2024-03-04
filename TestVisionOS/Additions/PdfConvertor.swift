//
//  PdfConvertor.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import UIKit
import CoreGraphics

func convertPDFToImages(pdfURL: URL) -> [UIImage]? {
    guard let document = CGPDFDocument(pdfURL as CFURL) else { return nil }
    var images: Array<UIImage> = []
    
    for i in 1...document.numberOfPages {
        guard let page = document.page(at: i) else { continue }
        let pageRect = page.getBoxRect(.mediaBox)
        
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        images.append(img)
    }
    
    return images
}

func convertPDFPageToImage(pdfURL: URL, page: Int) -> UIImage? {
    guard let document = CGPDFDocument(pdfURL as CFURL) else { return nil }

    guard let page = document.page(at: page) else { return nil }
    let pageRect = page.getBoxRect(.mediaBox)
    
    let renderer = UIGraphicsImageRenderer(size: pageRect.size)
    let img = renderer.image { ctx in
        UIColor.white.set()
        ctx.fill(pageRect)
        
        ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
        ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
        
        ctx.cgContext.drawPDFPage(page)
    }
        
    return img
}

func saveImage(_ image: UIImage, named: String) -> URL? {
    guard let data = image.pngData() else { return nil }
    let url = FileManager.default.temporaryDirectory.appendingPathComponent(named)
    do {
        try data.write(to: url)
        return url
    } catch {
        print("Error: \(error)")
        showAlert(withMessage: "Error saving the image")
        return nil
    }
}
