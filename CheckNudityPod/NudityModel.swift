//
//  NudityModel.swift
//  CheckNudityPod
//
//  Created by iMac on 14/11/22.
//

import Foundation
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
    func setImageInArray(completion: MFNudity.CompletionHandlerImageValue) {
        if let img = snapShot() {
            imageArray.append(img)
            self.duration = self.duration - self.durationSecond
            if self.duration > 0 {
                setImageInArray(completion: completion)
                return
            }
        }
        NudityModel.checkNudity(with: imageArray, completion: completion)
    }
    
    func snapShot() -> UIImage? {
        if self.duration > 0 {
            let capturedImage: UIImage? = getASnapShotWithAVLayer()
            return capturedImage
        }
        return nil
    }

    func getASnapShotWithAVLayer() -> UIImage? {
        let playerItem1 = AVPlayerItem(url: localVideoUrl)

        let temporaryViewForVideoOne = UIImageView(frame: UIScreen.main.bounds)
        var imageFromCurrentTimeForVideoOne: UIImage? = takeVideoSnapShot(playerItem1)
        var orientationFromVideoForVideoOne: Int = getTheActualOrientationOfVideo(playerItem1)
        if orientationFromVideoForVideoOne == 0 {
            orientationFromVideoForVideoOne = 3
        }
        else if orientationFromVideoForVideoOne == 90 {
            orientationFromVideoForVideoOne = 0
        }

        imageFromCurrentTimeForVideoOne = UIImage(cgImage: (imageFromCurrentTimeForVideoOne?.cgImage)!, scale: imageFromCurrentTimeForVideoOne!.scale, orientation: UIImage.Orientation(rawValue: orientationFromVideoForVideoOne) ?? .down)
        let rotatedImageFromCurrentContextForVideoOne: UIImage? = normalizedImage(imageFromCurrentTimeForVideoOne!)
        temporaryViewForVideoOne.clipsToBounds = true
        temporaryViewForVideoOne.image = rotatedImageFromCurrentContextForVideoOne
        var imageSize = CGSize.zero
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait {
            imageSize = UIScreen.main.bounds.size
        }
        else {
            imageSize = CGSize(width: CGFloat(UIScreen.main.bounds.size.height), height: CGFloat(UIScreen.main.bounds.size.width))
        }
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        for window: UIWindow in UIApplication.shared.windows {
            context.saveGState()
            context.translateBy(x: window.center.x, y: window.center.y)
            context.concatenate(window.transform)
            context.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y)
            if orientation == .landscapeLeft {
                context.rotate(by: M_PI_2)
                context.translateBy(x: 0, y: -imageSize.width)
            }
            else if orientation == .landscapeRight {
                context.rotate(by: -M_PI_2)
                context.translateBy(x: -imageSize.height, y: 0)
            }
            else if orientation == .portraitUpsideDown {
                context.rotate(by: .pi)
                context.translateBy(x: -imageSize.width, y: -imageSize.height)
            }
            if !window.responds(to: Selector("drawViewHierarchyInRect:afterScreenUpdates:")) {
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }
            else {
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }
            context.restoreGState()
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        temporaryViewForVideoOne.removeFromSuperview()
        return image!
    }

    func takeVideoSnapShot(_ playerItem: AVPlayerItem) -> UIImage {
        let asset: AVURLAsset? = (playerItem.asset as? AVURLAsset)
        let preferredTimerScale = Int32(asset!.duration.seconds * 10)
        let imageGenerator = AVAssetImageGenerator(asset: asset!)
        var time: CMTime = CMTimeMakeWithSeconds(self.duration, preferredTimescale: 1)
        let thumb: CGImage? = try? imageGenerator.copyCGImage(at: time, actualTime: nil)
        let videoImage = UIImage(cgImage: thumb!)
        return videoImage
    }
    
    func getTheActualOrientationOfVideo(_ playerItem: AVPlayerItem) -> Int {
        return 90
    }
    
    func normalizedImage(_ imageOf: UIImage) -> UIImage {
        if imageOf.imageOrientation == .up {
            return imageOf
        }
        UIGraphicsBeginImageContextWithOptions(imageOf.size, false, imageOf.scale)
        let normalizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage!
    }
}
