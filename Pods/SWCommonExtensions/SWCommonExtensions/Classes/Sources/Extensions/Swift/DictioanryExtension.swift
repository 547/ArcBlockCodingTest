//
//  DictioanryExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/27.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

public typealias StandardDictionary = [String : Any]

extension Dictionary {
    public func toNSDictionary() -> NSDictionary { return (self as NSDictionary) }
}

extension Dictionary {
    public func string(for key: String) -> String? { return toNSDictionary().string(for: key) }
    public func int(for key: String) -> Int? { return toNSDictionary().int(for: key) }
    public func float(for key: String) -> Float? { return toNSDictionary().float(for: key) }
    public func double(for key: String) -> Double? { return toNSDictionary().double(for: key) }
    public func bool(for key: String) -> Bool? { return toNSDictionary().bool(for: key) }
    public func decimal(for key: String) -> Decimal? { return string(for: key)?.decimal }
    public func dictionary<K, V>(for key: String) -> Dictionary<K, V>? {
        return toNSDictionary().value(forKey: key) as? [K : V]
    }
    public func standardDictionary(for key: String) -> StandardDictionary? {
        return toNSDictionary().value(forKey: key) as? StandardDictionary
    }
    public func anyArray(for key: String) -> [Any]? {
        return toNSDictionary().value(forKey: key) as? [Any]
    }
    public func array<T>(for key: String) -> [T]? {
        return toNSDictionary().value(forKey: key) as? [T]
    }
}

extension Dictionary {
    public mutating func merge<K, V>(with dictionarys: Dictionary<K, V>...) {
        for dictionary in dictionarys {
            for (key, value) in dictionary {
                updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}

public func + <K, V>(lhs: [K : V], rhs: [K : V]) -> [K : V] {
    var result = [K : V]()
    for (key, value) in lhs {
        result[key] = value
    }
    for (key, value) in rhs {
        result[key] = value
    }
    return result
}
public func += <K, V>(lhs: inout [K : V], rhs: [K : V]) {
    for (k, v) in rhs {
        lhs[k] = v
    }
}
