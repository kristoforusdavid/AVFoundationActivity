//
//  PreviewView.swift
//  AVFoundationActivity
//
//  Created by Jasmine Hanifa Mounir on 10/07/19.
//  Copyright © 2019 Jasmine Hanifa Mounir. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {

    override class var layerClass: AnyClass{
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer{
        return layer as! AVCaptureVideoPreviewLayer
    }

}
