//
//  NSDictionaryExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/27.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

extension NSDictionary {
    public func string(for key: String) -> String? {
        return self.object(forKey: key) as? String
    }
    public func int(for key: String) -> Int? {
        if let tempNumber = self.object(forKey: key) as? Int {
            return tempNumber
        } else if let tempString = self.string(for: key) {
            return Int(tempString)
        }
        return nil
    }
    public func float(for key: String) -> Float? {
        if let tempNumber = self.object(forKey: key) as? Float {
            return tempNumber
        } else if let tempInt = self.int(for: key) {
            return Float(tempInt)
        } else if let tempString = self.string(for: key) {
            return Float(tempString)
        }
        return nil
    }
    public func double(for key: String) -> Double? {
        if let float = float(for: key) {
            return Double(float)
        }
        return nil
    }
    public func bool(for key: String) -> Bool? {
        if let tempNumber = self.int(for: key) {
            return Bool(from: tempNumber)
        } else if let tempString = self.string(for: key) {
            return Bool(from: tempString)
        }
        return nil
    }
}
