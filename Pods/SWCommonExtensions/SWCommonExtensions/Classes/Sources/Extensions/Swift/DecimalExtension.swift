//
//  DecimalExtension.swift
//  SWExtensions
//
//  Created by seven on 2019/6/31.
//  Copyright © 2019年 CYCON.com. All rights reserved.
//

import Foundation
extension Decimal {
    public var number: NSDecimalNumber {
        let result = self as NSDecimalNumber
        return result
    }
    public var stringValue: String {
        return "\(self)"
    }
    public var intValue: Int {
        return number.intValue
    }
    ///获取该数值精确到几位数
    public var accuracy: Accuracy {
        return getAccuracy()
    }
    ///获取数值的字符串 根据该数值精确的位数
    public var accuracyString: String {
        return getAccuracyText()
    }
}
extension Decimal {
    public static var zero:Decimal{
        return Decimal.init(0)
    }
    public static var one:Decimal{
        return Decimal.init(1)
    }
    public static var ten:Decimal{
        return Decimal.init(10)
    }
    public static var hundred:Decimal{
        return Decimal.init(100)
    }
    public static var Thousand:Decimal{
        return Decimal.init(1000)
    }
}
extension Decimal {
    public enum Accuracy {
        ///数据本身的精确度
        case `default`
        ///整数
        case none
        ///精确到小数点后一位
        case tenths
        ///精确到小数点后两位
        case percentile
        ///精确到小数点后三位
        case thousands
    }
}
extension Decimal {
    ///转字符串 scale:精确到小数点后 XX 位 PS:会四舍五入
    public func toString(scale: Int) -> String {
        return rounding(mode: .plain, scale: scale).stringValue
    }
    ///转字符串 mode：取值模式(plain:四舍五入; up:只入; down：只舍; bankers:不知道) scale:精确到小数点后 XX 位
    public func toString(mode:RoundingMode,scale: Int) -> String {
        let value = rounding(mode: mode, scale: scale)
        return value.stringValue
    }
    /// 取值 mode：取值模式(plain:四舍五入; up:只入; down：只舍; bankers:不知道) scale:精确到小数点后 XX 位
    public func rounding(mode:RoundingMode,scale: Int) -> Decimal {
        var result = Decimal()
        let handler = NSDecimalNumberHandler.init(roundingMode: mode, scale: Int16(scale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        result = self.number.rounding(accordingToBehavior: handler).decimal
        return result
    }
}
extension Decimal {
    ///获取该数值精确到几位数
    public func getAccuracy() -> Accuracy {
        var result:Accuracy = .default
        let tempInt = rounding(mode: .down, scale: 0)
        let decimalPart = self - tempInt
        let zero = Decimal.zero
        let ten = Decimal.ten
        let hundred = Decimal.hundred
        let Thousand = Decimal.Thousand
        let tempToTenths = (decimalPart * ten).rounding(mode: .down, scale: 0)
        let tempToPercentile = (decimalPart * hundred).rounding(mode: .down, scale: 0)
        let tempToThousands = (decimalPart * Thousand).rounding(mode: .down, scale: 0)
        
        if tempToPercentile == zero && tempToTenths == zero && tempToThousands == zero {
            result = .none
        }else if tempToTenths * ten == tempToPercentile && tempToTenths * hundred == tempToThousands {
            result = .tenths
        }else if tempToPercentile * ten == tempToThousands {
            result = .percentile
        }else if tempToThousands != zero {
            result = .thousands
        }
        return result
    }
    ///获取数值的字符串 根据该数值精确的位数
    public func getAccuracyText() -> String {
        var result = "\(self)"
        switch accuracy {
        case .default:
            break
        case .none:
            result = toString(scale: 0)
        case .tenths:
            result = toString(scale: 1)
        case .percentile:
            result = toString(scale: 2)
        case .thousands:
            result = toString(scale: 3)
        }
        return result
    }
}
extension NSDecimalNumber {
    public var decimal: Decimal {
        let result = self as Decimal
        return result
    }
}
extension NSDecimalNumberHandler {
    ///四舍五入
    public static func plainRoundingMode(scale:Int16) -> NSDecimalNumberHandler {
        let handler = NSDecimalNumberHandler.init(roundingMode: .plain, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return handler
    }
    ///只舍
    public static func downRoundingMode(scale:Int16) -> NSDecimalNumberHandler {
        let handler = NSDecimalNumberHandler.init(roundingMode: .down, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return handler
    }
}
