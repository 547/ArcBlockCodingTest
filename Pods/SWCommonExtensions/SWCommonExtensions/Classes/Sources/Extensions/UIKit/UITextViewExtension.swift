//
//  UITextViewExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UITextView {
    public var length: Int { return text != nil ? text!.count : 0 }
}

extension UITextView {
    public func append(text: String, newLine: Bool = false) {
        if self.text == nil { self.text = "" }
        let middleText = newLine ? "\n" : ""
        let oldText = self.text ?? ""
        self.text = oldText + middleText + text
    }
    public func clean() {
        self.text = nil
    }
}
