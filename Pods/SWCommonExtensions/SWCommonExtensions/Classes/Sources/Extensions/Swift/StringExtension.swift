//
//  StringExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/16.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension String {
    public var length: Int { return self.count }
    public var nsstring: NSString { return self as NSString }
    public var empty: Bool { return isEmpty }
    
    public var intValue: Int? { return Int(self) }
    public var floatValue: Float? { return Float(self) }
    public var doubleValue: Double? { return Double(self) }
    
    public var securedPhoneNumber: String {
        guard isAllNumber() else { return self }
        guard length == 8 || length == 11 else { return self }
        let convertedPhoneNumberPreffix = substring(from: 0, to: length == 8 ? 2 : 3)
        let convertedPhoneNumberSuffix = substring(from: length - (length == 8 ? 3 : 4), to: length) 
        return "\(convertedPhoneNumberPreffix)\(length == 8 ? "***" : "****")\(convertedPhoneNumberSuffix)"
    }
    public var displayingPhoneNumber: String {
        guard isAllNumber(), length == 11 else { return self }
        let firstPart   = substring(from: 0, to: 3)
        let secondPart  = substring(from: 3, to: 7)
        let thirdPart   = substring(from: 7, to: 11)
        return "\(firstPart) \(secondPart) \(thirdPart)"
    }
}

extension String {
    public func toArray() -> [String] {
        return self.map { String($0) }
    }
}
extension String {
    public var reversed: String {
        var string = self
        string.reverse()
        return string
    }
    // 获取倒序排序后的字符串
    public mutating func reverse() {
        let mappedCharacters = self.map{ return $0 }
        let reversed = mappedCharacters.reversed()
        self = String(reversed)
    }
}
extension String {
    public subscript(start: Int, end: Int) -> String {
        get {
            guard end > start else { return "" }
            let theStartIndex = index(startIndex, offsetBy: start)
            var tempEnd = end
            if end > count {
                tempEnd = count
            }
            let theEndIndex = index(startIndex, offsetBy: tempEnd)
            return String(self[theStartIndex..<theEndIndex])
        }
        set {
            // 当 传递了错误的区间时，不操作
            guard end > start else { return }
            // 当 区间起始下标 大于 字符串末位下标 时，直接拼接字符串
            guard start < count else {
                self = "\(self)\(newValue)"
                return
            }
            // 当 区间末位下标 大于 字符串末位下标 时，替换至字符串末位下标，然后拼接剩余字符
            guard end < count else {
                
                return
            }
            let theFirstEndIndex = index(startIndex, offsetBy: start)
            let theSecondStartIndex = index(startIndex, offsetBy: end)
            let startString = self[..<theFirstEndIndex]
            let endString = self[theSecondStartIndex..<endIndex]
            self = "\(startString)\(newValue)\(endString)"
        }
    }
}
extension String {
    public func split(_ separator: Character) -> [String] {
        return self.split(separator: separator).map(String.init)
    }
    public func split(from start: Int, to end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    
    public func substring(from start: Int, to end: Int) -> String {
        return String(self[index(startIndex, offsetBy: start)..<index(startIndex, offsetBy: end)])
    }
}
extension String {
    public func isAllNumber() -> Bool {
        let inverseSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let components = self.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        return self == filtered
    }
    public func isAllSpace() -> Bool {
        let text = self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        return !(text.length > 0)
    }
    public func isUrl() -> Bool {
        return hasPrefix("http://") || hasPrefix("https://")
    }
    public func isEmail() -> Bool {
        var result = false
        guard !contains(" ") else {
            return result
        }
        guard !isAllSpace() else {
            return result
        }
        guard !containsChinese() else {
            return result
        }
        let at = "@"
        let point = "."
        let chars = components(separatedBy: at)
        guard chars.count > 1, let firstChar = chars.first, !firstChar.isAllSpace(), let lastChar = chars.last else {
            return result
        }
        print("last char \(lastChar)")
        guard lastChar.contains(point), !lastChar.hasPrefix(point), !lastChar.hasSuffix(point) else {
            return result
        }
        result = true
        return result
    }
    /// 是否包含汉字
    public func containsChinese() -> Bool {
        var result = false
        for item in self {
            if "\u{4E00}" <= item, item <= "\u{9FA5}"{
                result = true
                break
            }
        }
        return result
    }
}
extension String {
    public func trimWhitespacesOfHeadAndTail() -> String? {
        let result = self.trimmingCharacters(in: .whitespaces)
        if result.length > 0{
            return result
        }
        return nil
    }
}

extension String {
    public var decimal: Decimal? {
        return Decimal.init(string: self)
    }
}


extension String {
    public init(fromDate date: Date, dateFormat format: String) {
        let dateFormatter = DateFormatter(dateFormat: format)
        self = dateFormatter.string(from: date)
    }
    public func date(fromDateFormat format: String) -> Date? {
        let result = Date.init(fromString: self, dateFormat: format)
        return result
    }
    public func timeIntervalSince1970(fromDateFormat format: String) -> TimeInterval? {
        let result = Date.init(fromString: self, dateFormat: format)?.timestamp
        return result
    }
}
