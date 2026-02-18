import SwiftUI

struct BarcodeScannerView: View {

    @State private var scannedCode = "Not Yet Scanned"

    var body: some View {
        NavigationView {
            VStack {

                // Camera Preview
                ScannerView(scannedCode: $scannedCode)
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding()

                Spacer().frame(height: 40)

                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)

                Text(scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
	
