//
//  ContentView.swift
//  TestVisionOS
//
//  Created by Nikita Marton on 04.03.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var selectedPDF: String? = nil
    //@State private var isARButtonTapped: Bool = false
    @State private var isFileListVisible: Bool = true
    
    @State private var immersiveSpaceIsShown = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                withAnimation {
                    FileList(selectedPDF: $selectedPDF)
                        .frame(minWidth: 0, maxWidth: isFileListVisible ? 0.25 * UIScreen.main.bounds.width : 0)
                }
                Button(action: {
                    withAnimation {
                        isFileListVisible.toggle()
                    }
                }) {
                    Image(systemName: isFileListVisible ? "arrow.left.circle.fill" : "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }.padding(5)
            }
            PDFViewer(selectedPDF: $selectedPDF)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            /*VStack(alignment: .leading, spacing: 0) {
                ARButton(isTapped: $isARButtonTapped)
                    .padding()
                Spacer()
            }*/
        }
        .padding()
        .navigationTitle(selectedPDF ?? "Select a PDF from the list")
        .toolbar{
            (selectedPDF == nil) ? nil : ToolbarItemGroup(placement: .bottomOrnament) {
                Button {
                } label: {
                    Text("Approve")
                        .roundButton(color: Color.green)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Spacer()
                
                Button {
                } label: {
                    Text("Reject")
                        .roundButton(color: Color.red)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        /*.onChange(of: isARButtonTapped) { _, newValue in
            Task {
                if newValue {
                    immersiveSpaceIsShown = true
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        isARButtonTapped = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }*/
    }
}

struct FileList: View {
    @Binding var selectedPDF: String?
    
    var body: some View {
        List(["Praktikum_laboratorny", "Мартон_Н_А_12002333_задание_2", "БРС_№1_Статья_Мартон_12002333", "File 0"], id: \.self) { file in
            Button(action: {
                selectedPDF = file
            }) {
                Text(file).padding()
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct PDFViewer: View {
    @Binding var selectedPDF: String?

    var body: some View {
        if let selectedPDF = selectedPDF {
            if let pdfURL = Bundle.main.url(forResource: "\(selectedPDF).pdf", withExtension: nil) {
                PDFKitView(url: pdfURL)
                    .id(selectedPDF)
            } else {
                Text("PDF file not found")
            }
        } else {
            Text("Select a PDF from the list")
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

struct ARButton: View {
    @Binding var isTapped: Bool

    var body: some View {
        Button(action: {
            isTapped.toggle()
        }) {
            Image(systemName: "arkit")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
        .foregroundColor(.blue)
    }
}

#Preview(.automatic) {
    ContentView()
}
