//
//  ViewController.swift
//  AVFoundationActivity
//
//  Created by Jasmine Hanifa Mounir on 10/07/19.
//  Copyright © 2019 Jasmine Hanifa Mounir. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let captureSession = AVCaptureSession()
    var previewView = PreviewView()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer!
    var photoOutput = AVCapturePhotoOutput()
    var outputImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askCameraPermission{(granted) in
            if granted{
                DispatchQueue.main.async {
                    self.setupView()
                    DispatchQueue.global().async {
                        self.configurationSession()
                    }
                }
            }
        }
    }

    func askCameraPermission(completion: @escaping ((Bool) -> Void)){
        AVCaptureDevice.requestAccess(for: .video) {(granted) in
            if !granted{
                let alert = UIAlertController(title: "Message", message: "If you want........", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                    alert.dismiss(animated: true, completion: nil)
                    completion(false)
                })
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                completion(false)
            }
        }
    }
    
    //handle button event when the button did tap
    @objc func buttonShootDidTap(){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func setupView(){
        //configuring background color
        view.backgroundColor = .black
        
        //setting preview view for camera
        previewView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 650)
        view.addSubview(previewView)
        
        //setting button to take shoot
        let xPosition = (UIScreen.main.bounds.width / 2.0) - 40
        let yPosition = UIScreen.main.bounds.height - 170.0
        let buttonRect = CGRect(x: xPosition, y: yPosition, width: 80, height: 80)
        let buttonShoot = UIButton(frame: buttonRect)
        
        buttonShoot.backgroundColor = UIColor.white
        buttonShoot.layer.cornerRadius = buttonShoot.frame.width / 2.0
        buttonShoot.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonShootDidTap))
        buttonShoot.addGestureRecognizer(tap)
        
    
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
}

