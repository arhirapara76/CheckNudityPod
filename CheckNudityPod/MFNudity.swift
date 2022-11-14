//
//  MFNudity.swift
//  CheckNudity
//
//  Created by iMac on 11/11/22.
//

import Foundation
import Vision
import UIKit

public class MFNudity : NSObject{
    
    public static let shared = MFNudity()
    
    static let modelNudity = Nudity()
    
    let size = CGSize(width: 224, height: 224)
    
    public typealias CompletionHandler = (_ error:Error?,_ confidence:Double?, _ safConfidence:Double?) -> Void
    
    public typealias CompletionHandlerImageValue = (_ nsfwValue:String?, _ sfwValue:String?) -> Void

    public func checkImageNudity(image:UIImage,completion: CompletionHandler){
        let confidence : Double?
        let safConfidence : Double?
        
        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
            let error = NSError(domain: "Scaling or converting to pixel buffer failed!", code: 101, userInfo: nil)
            completion(error, nil, nil)
            return
        }
        
        guard let result = try? MFNudity.modelNudity.prediction(data: buffer) else {
            let error = NSError(domain: "Prediction failed!", code: 101, userInfo: nil)
            completion(error, nil, nil)
            return
        }
        confidence = result.prob["NSFW"]! * 100.0
        safConfidence = result.prob["SFW"]! * 100.0
        //result.prob["SFW"]! * 100.0
        completion(nil, confidence, safConfidence)
    }
}


