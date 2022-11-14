//
//  MFNudity.swift
//  MFNudity
//
//  Created by Mobilefirst on 11/9/17.
//  Copyright © 2017 MobileFirst. All rights reserved.
//

import Foundation
import Vision
import UIKit

public class MFNudity : NSObject{
    
    public static let shared = MFNudity()
    
    static let model = Nudity()
    
    let size = CGSize(width: 224, height: 224)
    
    public typealias CompletionHandler = (_ error:Error?,_ confidence:Double?) -> Void
    
    public func checkImageNudity(image:UIImage,completion: CompletionHandler){
        
        
        let confidence : Double?
        
        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
            
            let error = NSError(domain: "Scaling or converting to pixel buffer failed!", code: 101, userInfo: nil)
            completion(error, nil)
            return
        }
        
        guard let result = try? MFNudity.model.prediction(data: buffer) else {
            
            let error = NSError(domain: "Prediction failed!", code: 101, userInfo: nil)
            completion(error, nil)
            return
        }
        
        confidence = result.prob["NSFW"]! * 100.0
        completion(nil, confidence)
        
    }
    
}


