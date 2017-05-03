//
//  CameraViewController.swift
//  ClickMore
//
//  Created by Pransu Dash on 5/2/17.
//  Copyright © 2017 Pransu Dash. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var imageViewOverlay: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var sendImageButton: UIButton!
    
    // The image to send as a Snap
    var selectedImage = UIImage()
    
    // students will need to add these four instance variables
    
    // manages real time capture activity from input devices to create output media (photo/video)
    let captureSession = AVCaptureSession()
    
    // the device we are capturing media from (i.e. front camera of an iPhone 7)
    var captureDevice : AVCaptureDevice?
    
    // view that will let us preview what is being captured from the captureSession
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // Object used to capture a single photo from our capture device
    let photoOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        captureNewSession(devicePostion: AVCaptureDevicePosition.front)
        super.viewDidLoad()
        toggleUI(isInPreviewMode: false)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide the navigation bar while we are in this view
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureNewSession(devicePostion: AVCaptureDevicePosition) {
        
        // remove all the inputs and stop running the session so we can
        // flip the camera (use another DeviceInput)
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
        captureSession.stopRunning()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        if let deviceDiscoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                                             mediaType: AVMediaTypeVideo,
                                                                             position: AVCaptureDevicePosition.unspecified) {
            
            // Iterate through available devices until we find the user's
            for device in deviceDiscoverySession.devices {
                // only use device if it supports video
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if (device.position == devicePostion) {
                        captureDevice = device
                        if captureDevice != nil {
                            do {
                                // students need to add this line
                                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                                
                                if captureSession.canAddOutput(photoOutput) {
                                    captureSession.addOutput(photoOutput)
                                }
                            }
                            catch {
                                print("error: \(error.localizedDescription)")
                            }
                            
                            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                                view.layer.addSublayer(previewLayer)
                                previewLayer.frame = view.layer.frame
                                
                                // students need to add this line
                                captureSession.startRunning()
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            // students need to add write this part
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            selectedImage = UIImage(data: photoData!)!
            toggleUI(isInPreviewMode: true)
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        // students need to add write this part
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        photoOutput.capturePhoto(with: settingsForMonitoring, delegate: self)
    }
    
    func toggleUI(isInPreviewMode: Bool) {
        if isInPreviewMode {
            imageViewOverlay.image = selectedImage
            takePhotoButton.isHidden = true
            sendImageButton.isHidden = false
            
        }
        else {
            takePhotoButton.isHidden = false
            sendImageButton.isHidden = true
            imageViewOverlay.image = nil
        }
        
        // make sure all of the buttons appear in front of the previewLayer
        view.bringSubview(toFront: imageViewOverlay)
        view.bringSubview(toFront: sendImageButton)
        view.bringSubview(toFront: takePhotoButton)
    }

    @IBAction func sendPicture(_ sender: Any) {
        Images.addImage(image: selectedImage)
        performSegue(withIdentifier: "imageTaken", sender: HomeViewController())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
        if let dest = segue.destination as? EditImageController {
            dest.image = selectedImage
            toggleUI(isInPreviewMode: false)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
