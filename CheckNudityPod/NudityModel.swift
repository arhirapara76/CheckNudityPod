//
//  NudityModel.swift
//  CheckNudityPod
//
//  Created by iMac on 14/11/22.
//

import UIKit
import AVFoundation
import MobileCoreServices

public class NudityModel {
    
    static let shared = NudityModel()
    var localVideoUrl: URL!
    var imageArray = [UIImage]()
    var duration: Double = 0
    var finalvalue: Double = 0
    var durationSecond: Double = 0
    var videoLevel = CheckSecurityLevel.low
    
    public class func checkNudity(with imageArray: [UIImage], completion: MFNudity.CompletionHandlerImageValue) {
        var nsfwConfidence : String? = "0"
        var safwConfidence : String? = "0"
        if !imageArray.isEmpty {
            if imageArray.count == 1 {
                if let image = imageArray.first {
                    MFNudity.shared.checkImageNudity(image: image) { (error, nsafValue, safVale)  in
                        if error == nil {
                            let convertedSaf = String(format: "%.2f", safVale!)
                            let convertedNsaf = String(format: "%.2f", nsafValue!)
                            nsfwConfidence = convertedNsaf
                            safwConfidence = convertedSaf
                            completion(nsfwConfidence, safwConfidence)
                        } else {
                            print("error: ", error)
                        }
                    }
                }
            }else {
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
                    nsfwConfidence = convertedNsaf
                    safwConfidence = convertedSaf
                    completion(nsfwConfidence, safwConfidence)
                }
            }
        }
    }
}

//Check Nudity For Local Video URL
extension NudityModel {
    public class func checkLocalVideoUrlNudity(with localStringUrl: String, securityLevel: CheckSecurityLevel, completion: MFNudity.CompletionHandlerImageValue) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if !localStringUrl.starts(with: "file:///") {
            appDelegate.openAlert(with: "Error", message: "Please enter local URL")
            return
        }
        guard let localUrl = URL(string: localStringUrl) else {
            appDelegate.openAlert(with: "Error", message: "Please enter valid local URL")
            return
        }
        
        NudityModel.shared.localVideoUrl = localUrl
        NudityModel.shared.videoLevel = securityLevel
        
        switch securityLevel {
        case .high:
            NudityModel.shared.durationSecond = 1
        case .mid:
            NudityModel.shared.durationSecond = 2
        case .low:
            NudityModel.shared.durationSecond = 4
        }
        NudityModel.shared.imageArray.removeAll()
        let asset = AVAsset(url: localUrl)
        NudityModel.shared.duration = asset.duration.seconds
        if NudityModel.shared.duration < 4 {
            NudityModel.shared.durationSecond = 1
        }
        NudityModel.shared.setImageInArray(completion: completion)
    }
}

//Create video Screen sort
extension NudityModel {
    private func setImageInArray(completion: MFNudity.CompletionHandlerImageValue) {
        if let img = getASnapShotWithAVLayer() {
            imageArray.append(img)
            self.duration = self.duration - self.durationSecond
            if self.duration > 0 {
                setImageInArray(completion: completion)
                return
            }
        }
        NudityModel.checkNudity(with: imageArray, completion: completion)
    }

    private func getASnapShotWithAVLayer() -> UIImage? {
        let playerItem = AVPlayerItem(url: localVideoUrl)
        let imageFromCurrentTimeForVideoOne: UIImage? = takeVideoSnapShot(playerItem)
        return imageFromCurrentTimeForVideoOne
    }

    private func takeVideoSnapShot(_ playerItem: AVPlayerItem) -> UIImage {
        let asset: AVURLAsset? = (playerItem.asset as? AVURLAsset)
        let imageGenerator = AVAssetImageGenerator(asset: asset!)
        let time: CMTime = CMTimeMake(value: Int64(self.duration), timescale: 1)
        let thumb: CGImage? = try? imageGenerator.copyCGImage(at: time, actualTime: nil)
        let videoImage = UIImage(cgImage: thumb!)
        return videoImage
    }
}
