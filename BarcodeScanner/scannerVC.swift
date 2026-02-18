import UIKit
import AVFoundation

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
}

final class ScannerVC: UIViewController {

    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?

    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.layer.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    private func setupCamera() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            configureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.configureSession()
                    } else {
                        print("Camera permission denied")
                    }
                }
            }
        case .denied, .restricted:
            print("Camera permission denied or restricted")
        @unknown default:
            print("Unknown camera authorization status")
        }
    }

    private func configureSession() {

        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            print("Camera not available")
            return
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)

            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                print("Cannot add input")
                return
            }
        } catch {
            print("Error setting up camera: \(error)")
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            metadataOutput.metadataObjectTypes = [
                .qr,
                .ean8,
                .ean13,
                .code128
            ]
        } else {
            print("Cannot add metadata output")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill

        if let previewLayer = previewLayer {
            view.layer.addSublayer(previewLayer)
        }

        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let barcode = metadataObject.stringValue {

            scannerDelegate?.didFind(barcode: barcode)
        }
    }
}
