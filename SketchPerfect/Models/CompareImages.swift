//
//  CompareImages.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 23/11/22.
//

import Foundation
import Vision
import UIKit

//extension CGImagePropertyOrientation {
//    init(_ uiOrientation: UIImage.Orientation) {
//        switch uiOrientation {
//            case .up: self = .up
//            case .upMirrored: self = .upMirrored
//            case .down: self = .down
//            case .downMirrored: self = .downMirrored
//            case .left: self = .left
//            case .leftMirrored: self = .leftMirrored
//            case .right: self = .right
//            case .rightMirrored: self = .rightMirrored
//        }
//    }
//}
//
//public extension UIImage {
//    func croppedImage(inRect rect: CGRect) -> UIImage {
//        let rad: (Double) -> CGFloat = { deg in
//            return CGFloat(deg / 180.0 * .pi)
//        }
//        var rectTransform: CGAffineTransform
//        switch imageOrientation {
//        case .left:
//            let rotation = CGAffineTransform(rotationAngle: rad(90))
//            rectTransform = rotation.translatedBy(x: 0, y: -size.height)
//        case .right:
//            let rotation = CGAffineTransform(rotationAngle: rad(-90))
//            rectTransform = rotation.translatedBy(x: -size.width, y: 0)
//        case .down:
//            let rotation = CGAffineTransform(rotationAngle: rad(-180))
//            rectTransform = rotation.translatedBy(x: -size.width, y: -size.height)
//        default:
//            rectTransform = .identity
//        }
//        rectTransform = rectTransform.scaledBy(x: scale, y: scale)
//        let transformedRect = rect.applying(rectTransform)
//        let imageRef = cgImage!.cropping(to: transformedRect)!
//        let result = UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
//        return result
//    }
//}

public class CompareImages {
//    @Published var pathLayer: CALayer?
//    @Published var detectedBounds: CGRect?

//    var rectangleDetectionRequest: VNDetectRectanglesRequest = {
//        let request = VNDetectRectanglesRequest()
//        request.maximumObservations = 8
//        request.minimumConfidence = 0.6
//        request.minimumAspectRatio = 0.3
//        return request
//    }()
//    
//    fileprivate func performVisionRequest(image: CGImage, orientation: CGImagePropertyOrientation) {
//        let imageRequestHandler = VNImageRequestHandler(cgImage: image, orientation: orientation, options: [:])
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                try imageRequestHandler.perform([])
//            } catch {
//                print("Image Request Failed: \(error)")
//                return
//            }
//        }
//    }
//    
//    lazy var objectDetectionRequest: VNDetectTextRectanglesRequest = {
//        let request = VNDetectTextRectanglesRequest(completionHandler: self.handleDetectedObject)
//        // Tell Vision to report bounding box around each character.
//        request.reportCharacterBoxes = true
//        return request
//    }()
//    
//    fileprivate func handleDetectedObject(request: VNRequest?, error: Error?) {
//        if let nsError = error as NSError? {
//            print("Object Detection Error: \(nsError)")
//            return
//        }
//        // Perform drawing on the main thread.
//        DispatchQueue.main.async {
//            guard let drawLayer = self.pathLayer,
//                let results = request?.results as? [VNTextObservation] else {
//                    return
//            }
//            self.crop(object: results, bounds: drawLayer.bounds)
//            drawLayer.setNeedsDisplay()
//        }
//    }
//    
//    fileprivate func boundingBox(forRegionOfInterest: CGRect, withinImageBounds bounds: CGRect) -> CGRect {
//        
//        let imageWidth = bounds.width
//        let imageHeight = bounds.height
//        
//        // Begin with input rect.
//        var rect = forRegionOfInterest
//        
//        // Reposition origin.
//        rect.origin.x *= imageWidth
//        rect.origin.x += bounds.origin.x
//        rect.origin.y = (1 - rect.origin.y) * imageHeight + bounds.origin.y
//        
//        // Rescale normalized coordinates.
//        rect.size.width *= imageWidth
//        rect.size.height *= imageHeight
//        
//        return rect
//    }
//    
//    fileprivate func crop(object: [VNTextObservation], bounds: CGRect) {
//        for objObservation in object {
//            guard let charBoxes = objObservation.characterBoxes else { continue }
//            
//            for charObservation in charBoxes {
//                detectedBounds = boundingBox(forRegionOfInterest: charObservation.boundingBox, withinImageBounds: bounds)
//            }
//        }
//    }
//    
//    func cropImage(imageToCrop image: UIImage) -> UIImage? {
//        guard let cgImage = image.cgImage else {
//            return nil
//        }
//        
//        performVisionRequest(image: cgImage, orientation: CGImagePropertyOrientation(image.imageOrientation))
//        
//        guard let bounds = detectedBounds else {
//            return nil
//        }
//        
//        return image.croppedImage(inRect: bounds)
//    }
    
//    func featureprintObservationForImage(image: UIImage) -> VNFeaturePrintObservation? {
//        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
//        let request = VNGenerateImageFeaturePrintRequest()
//        request.usesCPUOnly = true // Simulator Testing
//
//        do {
//            try requestHandler.perform([request])
//            return request.results?.first as? VNFeaturePrintObservation
//        } catch {
//            print("Vision Error: \(error)")
//            return nil
//        }
//    }
    
    func featureprintObservationForImage(image: UIImage) -> VNFeaturePrintObservation? {
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        request.usesCPUOnly = true // Simulator Testing

        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            print("Vision Error: \(error)")
            return nil
        }
    }

    func compare(origImg: UIImage, drawnImg: UIImage) -> Float? {
        let oImgObservation = featureprintObservationForImage(image: origImg)
        let dImgObservation = featureprintObservationForImage(image: drawnImg)
        
        if let oImgObservation = oImgObservation {
            if let dImgObservation = dImgObservation {
                var distance: Float = -1

                do {
                    try oImgObservation.computeDistance(&distance, to: dImgObservation)
                } catch {
                    fatalError("Failed to Compute Distance")
                }

                if distance == -1 {
                    return nil
                } else {
                    return distance
                }
            } else {
                print("Drawn Image Observation found Nil")
            }
        } else {
            print("Original Image Observation found Nil")
        }
        return nil
    }
//    func pixelValues(fromCGImg image: CGImage?) -> [UInt8]? {
//        var width = 0
//        var height = 0
//        var pixelVals: [UInt8]?
//
//        if let image = image {
//            width = image.width
//            height = image.height
//
//            let bitsPerComponent = image.bitsPerComponent
//            let bytesPerRow = image.bytesPerRow
//            let totalNumOfBytes = bytesPerRow * height
//            let bitmapInfo = image.bitmapInfo
//
//            let colourSpace = CGColorSpaceCreateDeviceRGB()
//            var colourIntensities = [UInt8](repeating: 0, count: totalNumOfBytes)
//
//            let contextRef = CGContext(data: &colourIntensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colourSpace, bitmapInfo: bitmapInfo.rawValue)
//            contextRef?.draw(image, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
//
//            pixelVals = colourIntensities
//        }
//
//        return pixelVals
//    }
//
//    func compareImages(originalImage: UIImage, drawnImage: UIImage) -> Double? {
//        let originalImgData = pixelValues(fromCGImg: originalImage.cgImage)
//        let drawnImgData = pixelValues(fromCGImg: drawnImage.cgImage)
//
//        if let originalImgData = originalImgData {
//            if let drawnImgData = drawnImgData {
//                if originalImgData.count != drawnImgData.count {
//                    return nil
//                }
//            } else {
//                return nil
//            }
//        } else {
//            return nil
//        }
//
//        let width = Double(originalImage.size.width)
//        let height = Double(originalImage.size.height)
//
//        let zipDat = zip(originalImgData!, drawnImgData!).enumerated().reduce(0.0) { $1.offset % 4 == 3 ? $0 : $0 + abs(Double($1.element.0) - Double($1.element.1)) }
//
//        return zip * 100 / (width * height * 3.0) / 255.0
//    }
}
