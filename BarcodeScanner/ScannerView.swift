import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    @Binding var scannedCode: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}

    class Coordinator: NSObject, ScannerVCDelegate {

        var parent: ScannerView

        init(_ parent: ScannerView) {
            self.parent = parent
        }

        func didFind(barcode: String) {
            parent.scannedCode = barcode
        }
    }
}
