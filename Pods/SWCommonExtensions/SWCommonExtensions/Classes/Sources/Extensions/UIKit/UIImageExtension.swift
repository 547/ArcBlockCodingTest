//
//  UIImageExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIImage {
    ///旋转图片
    public func rotate(orientation:UIImage.Orientation) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        return UIImage.init(cgImage: cgImage, scale: self.scale, orientation: orientation)
    }
}
extension UIImage {
    public func resized(_ percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    public func resized(_ newSize: CGSize) -> UIImage? {
        let canvasSize = newSize
        //MARK:使用UIScreen.main.scale替代self.scale可以避免绘制出来的image模糊
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIImage {
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，可能结果会大于maxSize)
    /// - Parameter maxKBSize: 以KB为单位
    /// - Returns: 压缩后的图片
    public func compressImage(maxKBSize:Int) -> UIImage?{
        var result:UIImage? = nil
        guard let data = compressImageData(maxKBSize: maxKBSize) else {
            return result
        }
        result = UIImage(data: data)
        return result
    }
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，可能结果会大于maxSize)
    /// - Parameter maxKBSize: 以KB为单位
    /// - Returns: 压缩后的图片的data
    public func compressImageData(maxKBSize:Int) -> Data?{
        let result:Data? = compressImageData(maxSize: maxKBSize, byteUnits: .KB)
        return result
    }
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，可能结果会大于maxSize)
    /// - Parameter maxMBSize: 以MB为单位
    /// - Returns: 压缩后的图片
    public func compressImage(maxMBSize:Int) -> UIImage?{
        var result:UIImage? = nil
        guard let data = compressImageData(maxMBSize: maxMBSize) else {
            return result
        }
        result = UIImage(data: data)
        return result
    }
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，可能结果会大于maxSize)
    /// - Parameter maxMBSize: 以MB为单位
    /// - Returns: 压缩后的图片的data
    public func compressImageData(maxMBSize:Int) -> Data?{
        let result:Data? = compressImageData(maxSize: maxMBSize, byteUnits: .MB)
        return result
    }
    
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，可能结果会大于maxSize)
    /// - Parameters:
    ///   - maxSize: 最大size的值
    ///   - byteUnits: 最大size的单位
    /// - Returns: 压缩后的图片
    public func compressImage(maxSize:Int, byteUnits:ByteUnits) -> UIImage?{
        var result:UIImage? = nil
        guard let data = compressImageData(maxSize: maxSize, byteUnits: byteUnits) else {
            return result
        }
        result = UIImage(data: data)
        return result
    }
    /// 压缩图片(尽可能的将图片的size压缩到接近maxSize，maxSize太小的话很有可能结果会大于maxSize)
    /// - Parameters:
    ///   - maxSize: 最大size的值
    ///   - byteUnits: 最大size的单位
    /// - Returns: 压缩后的图片的data
    public func compressImageData(maxSize:Int, byteUnits:ByteUnits) -> Data?{
        var compress:CGFloat = 1.0
        var imageData:Data? = nil
        guard let jpgData = self.jpegData(compressionQuality: compress) else {
            return imageData
        }
        imageData = jpgData
        let byteSize = byteUnits.getBytes(maxSize)
        guard jpgData.count > byteSize else {
            return imageData
        }
        var min:CGFloat = 0
        var max:CGFloat = 1
        while (imageData?.count ?? 0) > byteSize || Double(imageData?.count ?? 0) < Double(byteSize) * 0.95 {
            //采用二分法尽可能减少压缩次数
            if (imageData?.count ?? 0) > byteSize {
                max = compress
            }else if (imageData?.count ?? 0) < byteSize {
                min = compress
            }
            compress = (max + min) * 0.5
            guard let data = self.jpegData(compressionQuality: compress) else { break }
            //压缩到一定的程度了，继续压缩也没有效果了
            guard imageData?.count != data.count else { break }
            imageData = data
        }
        return imageData
    }
}
public enum ByteUnits:String {
    case B = "bytes"
    case KB = "k"
    case MB = "m"
    case GB = "g"
    case TB = "t"
    ///转成byte
    public func getBytes(_ value:Int) -> Int {
        let baseUnit = 1024.0
        switch self {
        case .B:
            return value
        case .KB:
            return value * Int(baseUnit)
        case .MB:
            return value * Int(pow(baseUnit, 2.0))
        case .GB:
            return value * Int(pow(baseUnit, 3.0))
        case .TB:
            return value * Int(pow(baseUnit, 4.0))
        }
    }
    ///向上转换
    public func upwardConversion(_ bytes:Int) -> Int {
        let baseUnit = 1024.0
        switch self {
        case .B:
            return bytes
        case .KB:
            return bytes / Int(baseUnit)
        case .MB:
            return bytes / Int(pow(baseUnit, 2.0))
        case .GB:
            return bytes / Int(pow(baseUnit, 3.0))
        case .TB:
            return bytes / Int(pow(baseUnit, 4.0))
        }
    }
}
