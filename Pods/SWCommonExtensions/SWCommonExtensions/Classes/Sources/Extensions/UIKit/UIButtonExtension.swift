//
//  UIButtonExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIButton {
    public var titleForNormal: String? {
        get             { return title(for: .normal) }
        set (newValue)  { setTitle(newValue, for: .normal) }
    }
    public var titleColorForNormal: UIColor? {
        get             { return titleColor(for: .normal) }
        set (newValue)  { setTitleColor(newValue, for: .normal) }
    }
    public var imageForNormal: UIImage? {
        get             { return image(for: .normal) }
        set (newValue)  { setImage(newValue, for: .normal) }
    }
    
    public var titleForHighlighted: String? {
        get             { return title(for: .highlighted) }
        set (newValue)  { setTitle(newValue, for: .highlighted) }
    }
    public var titleColorForHighlighted: UIColor? {
        get             { return titleColor(for: .highlighted) }
        set (newValue)  { setTitleColor(newValue, for: .highlighted) }
    }
    public var imageForHighlighted: UIImage? {
        get             { return image(for: .highlighted) }
        set (newValue)  { setImage(newValue, for: .highlighted) }
    }
    
    public var titleForSelected: String? {
        get             { return title(for: .selected) }
        set (newValue)  { setTitle(newValue, for: .selected) }
    }
    public var titleColorForSelected: UIColor? {
        get             { return titleColor(for: .selected) }
        set (newValue)  { setTitleColor(newValue, for: .selected) }
    }
    public var imageForSelected: UIImage? {
        get             { return image(for: .selected) }
        set (newValue)  { setImage(newValue, for: .selected) }
    }
    
    public var font: UIFont? {
        get             { return titleLabel?.font }
        set (newValue)  { titleLabel?.font = newValue }
    }
}
