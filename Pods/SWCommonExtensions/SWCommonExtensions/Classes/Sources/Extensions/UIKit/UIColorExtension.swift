//
//  UIColorExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIColor {
    public var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white >= 0.5
    }
    public var isDark: Bool { return isLight.opposite }
}

extension UIColor {
    public class var groupTableViewBackground: UIColor {
        return UIColor(hex: 0xEBEBF1)
    }
    public class var scrollViewTexturedBackground: UIColor {
        return UIColor(hex: 0x5C5E66)
    }
}

extension UIColor {
    /// 简化初始化方法，省去 除以255，直接键入RGB对应的数值，Alpha默认为1
    public convenience init(directlyRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    /// 简化初始化方法，直接键入HSB(色调、饱和度、亮度)，省去除以256
    public convenience init(directlyHue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat = 1) {
        self.init(hue: hue / 256, saturation: saturation / 256, brightness: brightness / 256, alpha: alpha)
    }
    
    /// 简化初始化方法，直接用颜色的hex值初始化，0xFFFFFF
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        let red     = CGFloat(((hex & 0xFF0000) >> 16))
        let green   = CGFloat(((hex & 0xFF00) >> 8))
        let blue    = CGFloat((hex & 0xFF))
        self.init(directlyRed: red, green: green, blue: blue, alpha: alpha)
    }
    /// 根据颜色的16进制字符串生成颜色
    public convenience init(hex: String) {
        var red:UInt32 = 0
        var green:UInt32 = 0
        var blue:UInt32 = 0
        Scanner.init(string: String(hex[hex.startIndex..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt32(&red)
        Scanner.init(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt32(&green)
        Scanner.init(string: String(hex[hex.index(hex.startIndex, offsetBy: 4)..<hex.index(hex.startIndex, offsetBy: 6)])).scanHexInt32(&blue)
        self.init(directlyRed: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
    }
}
extension UIColor {
    /// Return RGB value of current color.
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        return (fRed, fGreen, fBlue, fAlpha)
    }
}
