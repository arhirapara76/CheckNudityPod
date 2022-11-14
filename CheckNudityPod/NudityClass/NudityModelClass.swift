//
//  NudityModelClass.swift
//  CheckNudityPod
//
//  Created by iMac on 14/11/22.
//

import Foundation
import UIKit

public class NudityModelClass {
    
    public class func checkNudity(with imageArray: [UIImage], completion: MFNudity.CompletionHandlerImageValue) {
        var confidence : String? = "0"
        var safConfidence : String? = "0"
        if !imageArray.isEmpty {
            if let image = imageArray.first {
                MFNudity.shared.checkImageNudity(image: image) { (error, nsafValue, safVale)  in
                    if error == nil {
                        let convertedSaf = String(format: "%.2f", safVale!)
                        let convertedNsaf = String(format: "%.2f", nsafValue!)
                        confidence = convertedNsaf
                        safConfidence = convertedSaf
                        completion(confidence, safConfidence)
                    } else {
                        print("error: ", error)
                    }
                }
            } else {
                var imageCount = 0
                var safeValue: Double = 0
                var nsafeValue: Double = 0
                for imageValue in imageArray {
                    MFNudity.shared.checkImageNudity(image: imageValue) { (error, nsafValue, safVale)  in
                        if error == nil {
                            safeValue += safVale ?? 0.0
                            nsafeValue += nsafValue ?? 0.0
                            imageCount += 1
                        } else {
                            print("error: ", error)
                        }
                    }
                }
                if imageCount == imageArray.count {
                    safeValue = safeValue / Double(imageArray.count)
                    nsafeValue = nsafeValue / Double(imageArray.count)
                    let convertedSaf = String(format: "%.2f", safeValue)
                    let convertedNsaf = String(format: "%.2f", nsafeValue)
                    confidence = convertedSaf
                    safConfidence = convertedNsaf
                    completion(confidence, safConfidence)
                }
            }
        }
    }
}
