//
//  SWCurrency.swift
//  SWExtensions
//
//  Created by Seven on 26/6/2019.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation 
public class SWCurrency {
    public var unit: Unit
    
    private var amountValue: Decimal = Decimal.zero
    public var amount: Decimal{
        get{
            var result = amountValue
            if !accurateCalculation {
                result = amountValue.rounding(mode: .up, scale: 2)
            }
//            print("get=====amountValue:\(amountValue),result:\(result),accurateCalculation:\(accurateCalculation)")
            return result
        }
        set{
            if newValue < Decimal.zero {
                amountValue = Decimal.zero
            }else{
                amountValue = newValue
            }
//            print("set=====amountValue:\(amountValue),newValue:\(newValue)")
        }
    }
    ///关于amount 精确计算 false 就以精确到小数点后2位的值进行运算。 true 就根据数值本身进行运算
    public var accurateCalculation: Bool = false
    ///仅关于与description false 就精确到小数点后2位。 true 就根据数值本身精确的位数自动去末尾的0（PS:目前最多支持到小数点后3位）
    public var automaticallyRounded: Bool = false
    
    fileprivate init(unit: Unit, amount: Decimal) {
        self.unit = unit
        self.amount = amount
    }
    
    public static func MOP(_ amount: Decimal) -> SWCurrency {
        return SWCurrency(unit: .MOP, amount: amount)
    }
    public static func HKD(_ amount: Decimal) -> SWCurrency {
        return SWCurrency(unit: .HKD, amount: amount)
    }
    public static func CNY(_ amount: Decimal) -> SWCurrency {
        return SWCurrency(unit: .CNY, amount: amount)
    }
    public static func USD(_ amount: Decimal) -> SWCurrency {
        return SWCurrency(unit: .USD, amount: amount)
    }
    public static func MOP(_ amount: Int) -> SWCurrency {
        return SWCurrency(unit: .MOP, amount: Decimal.init(amount))
    }
    public static func HKD(_ amount: Int) -> SWCurrency {
        return SWCurrency(unit: .HKD, amount: Decimal.init(amount))
    }
    public static func CNY(_ amount: Int) -> SWCurrency {
        return SWCurrency(unit: .CNY, amount: Decimal.init(amount))
    }
    public static func USD(_ amount: Int) -> SWCurrency {
        return SWCurrency(unit: .USD, amount: Decimal.init(amount))
    }
}
extension SWCurrency: CustomStringConvertible {
    public var description: String {
        let formattedString: String = {
            if automaticallyRounded {
                return "\(unit.symbol)\(self.amount.accuracyString)"
            } else {
                return "\(unit.symbol)\(self.amount.toString(mode: .up, scale: 2))"
            }
        }()
        return formattedString
    }
}
extension SWCurrency: Equatable, Comparable {
    public static func == (lhs: SWCurrency, rhs: SWCurrency) -> Bool {
        return lhs.unit == rhs.unit && lhs.amount == rhs.amount
    }
    
    public static func < (lhs: SWCurrency, rhs: SWCurrency) -> Bool {
        return lhs.amount < rhs.amount
    }
    public static func > (lhs: SWCurrency, rhs: SWCurrency) -> Bool {
        return lhs.amount > rhs.amount
    }
    public static func >= (lhs: SWCurrency, rhs: SWCurrency) -> Bool {
        return lhs.amount >= rhs.amount
    }
    public static func <= (lhs: SWCurrency, rhs: SWCurrency) -> Bool {
        return lhs.amount <= rhs.amount
    }
    
    public static func < (lhs: SWCurrency, rhs: Decimal) -> Bool {
        return lhs.amount < rhs
    }
    public static func > (lhs: SWCurrency, rhs: Decimal) -> Bool {
        return lhs.amount > rhs
    }
    public static func >= (lhs: SWCurrency, rhs: Decimal) -> Bool {
        return lhs.amount >= rhs
    }
    public static func <= (lhs: SWCurrency, rhs: Decimal) -> Bool {
        return lhs.amount <= rhs
    }
    
    public static func < (lhs: Decimal, rhs: SWCurrency) -> Bool {
        return lhs < rhs.amount
    }
    public static func > (lhs: Decimal, rhs: SWCurrency) -> Bool {
        return lhs > rhs.amount
    }
    public static func >= (lhs: Decimal, rhs: SWCurrency) -> Bool {
        return lhs >= rhs.amount
    }
    public static func <= (lhs: Decimal, rhs: SWCurrency) -> Bool {
        return lhs <= rhs.amount
    }
    
    public static func + (lhs: SWCurrency, rhs: SWCurrency) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: lhs.amount + rhs.amount)
    }
    public static func + (lhs: SWCurrency, rhs: Decimal) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: lhs.amount + rhs)
    }
    public static func + (lhs: SWCurrency, rhs: Int) -> SWCurrency {
        return lhs + Decimal.init(rhs)
    }
    public static func += (lhs: SWCurrency, rhs: SWCurrency) {
        if lhs.unit == rhs.unit {
            lhs.amount += rhs.amount
        }
    }
    public static func += (lhs: inout SWCurrency, rhs: Decimal) {
        lhs.amount += rhs
    }
    public static func += (lhs: inout SWCurrency, rhs: Int) {
        lhs.amount += Decimal.init(rhs)
    }
    
    public static func - (lhs: SWCurrency, rhs: SWCurrency) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: lhs.amount > rhs.amount ? lhs.amount - rhs.amount : Decimal.zero)
    }
    public static func - (lhs: SWCurrency, rhs: Decimal) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: (lhs.amount > rhs ? lhs.amount - rhs : Decimal.zero))
    }
    public static func - (lhs: SWCurrency, rhs: Int) -> SWCurrency {
        return lhs - Decimal.init(rhs)
    }
    public static func -= (lhs: inout SWCurrency, rhs: Decimal) {
        lhs.amount = (lhs.amount > rhs ? lhs.amount - rhs : Decimal.zero)
    }
    public static func -= (lhs: inout SWCurrency, rhs: Int) {
        lhs.amount -= (lhs.amount > Decimal.init(rhs) ? lhs.amount - Decimal.init(rhs) : Decimal.zero)
    }
    
    public static func * (lhs: SWCurrency, rhs: SWCurrency) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: lhs.amount * rhs.amount)
    }
    public static func * (lhs: SWCurrency, rhs: Decimal) -> SWCurrency {
        return SWCurrency(unit: lhs.unit, amount: lhs.amount * rhs)
    }
    public static func * (lhs: SWCurrency, rhs: Int) -> SWCurrency {
        return lhs * Decimal.init(rhs)
    }
    public static func *= (lhs: inout SWCurrency, rhs: Decimal) {
        lhs.amount *= rhs
    }
    public static func *= (lhs: inout SWCurrency, rhs: Int) {
        lhs.amount *= Decimal.init(rhs)
    }
}
extension SWCurrency {
    public indirect enum Unit {
        case CNY
        case MOP
        case HKD
        case USD
        case GBP
        case JPY
        case EUR
        
        public var symbol: String {
            var symbol: String = ""
            switch self {
            case .CNY: symbol = "￥"
            case .MOP: symbol = "MOP"
            case .HKD: symbol = "HKD"
            case .USD: symbol = "$"
            case .GBP: symbol = "£"
            case .JPY: symbol = "￥"
            case .EUR: symbol = "€"
            }
            return symbol
        }
    }
}
