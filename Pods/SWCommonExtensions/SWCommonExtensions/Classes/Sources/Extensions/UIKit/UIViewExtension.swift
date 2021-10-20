//
//  UIViewExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIView {
    public static var NIB_NAME: String { return String(describing: self) }
    public var nibName: String { return String(describing: self) }
}

extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        set(newValue) {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        set(newValue) {
            layer.borderColor = newValue?.cgColor
            if let newValue = newValue, newValue != UIColor.clear {
                layer.borderWidth = 1
            }
        }
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
    }
    @IBInspectable public var borderWidth: CGFloat {
        set(newValue) {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable public var shadowColor: UIColor? {
        set(newValue) {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
    }
    @IBInspectable public var shadowOffset: CGSize {
        set(newValue) {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    @IBInspectable public var shadowRadius: CGFloat {
        set(newValue) {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    @IBInspectable public var shadowOpacity: Float {
        set(newValue) {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    @IBInspectable public var shadowPath: CGPath? {
        set(newValue) {
            layer.shadowPath = newValue
        }
        get {
            return layer.shadowPath
        }
    }
}

extension UIView {
    @discardableResult
    public class func instanceFromNib(nibNameOrNil: String? = nil) -> Self? {
        return instanceFromNib(nibNameOrNil: nibNameOrNil, type: self)
    }
    @discardableResult
    public class func instanceFromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = NIB_NAME
        }
        guard let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil) else { return nil }
        for tempView in nibViews {
            if let instance = tempView as? T {
                return instance
            }
        }
        return nil
    }
}
extension UIView {
    public func rounded(corners:UIRectCorner, frame:CGRect, cornerRadius:CGFloat = 0, backgroundColor:UIColor = UIColor.white, borderColor:UIColor? = nil, borderWidth:CGFloat = 0) -> () {
        self.backgroundColor = UIColor.clear
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        let path = UIBezierPath.init(roundedRect: maskLayer.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        maskLayer.path = path.cgPath
        maskLayer.strokeColor = borderColor?.cgColor
        maskLayer.fillColor = backgroundColor.cgColor
        maskLayer.lineWidth = borderWidth
        layer.insertSublayer(maskLayer, at: 0)
    }
}
