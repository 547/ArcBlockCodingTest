//
//  BoolExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/27.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

extension Bool {
    public var opposite: Bool { return !self }
    public var right: Bool { return self == true }
    public var negative: Bool {return self == false }
}
extension Bool {
    public init(from stringValue: String?) {
        self = false
        if let stringValue = stringValue {
            self = (stringValue == "1")
        }
    }
    public init(from intValue: Int?) {
        self = false
        if let intValue = intValue {
            self = (intValue == 1)
        }
    }
}

extension Bool {
    public var int: Int { return self == true ? 1 : 0 }
    public var string: String { return self == true ? "1" : "0" }
    public func toInt() -> Int { return int }
    public func toString() -> String { return string }
}

extension Bool {
    public var yes: Bool { return self == true }
    public var positive: Bool { return yes }
    public var no : Bool { return self == false }
}


extension Bool {
    public mutating func toggle() { self = !self }
}
