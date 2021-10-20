//
//  DateExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/28.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

extension Date {
    /// Convert current date/time to timestamp
    public var timestamp: TimeInterval { return timeIntervalSince1970 }
}
extension Date {
    /// init date with string e.g. 2019-01-26 10:34:10 with format e.g. yyyy-MM-dd HH:mm:ss
    public init?(fromString dateString: String, dateFormat: String) {
        let dateFormatter = DateFormatter(dateFormat: dateFormat)
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        self = date
    }
}
extension Date {
    /// Returns all the components of current date.
    public func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    } 
}
extension Date {
    public func offset(from date: Date, component: Calendar.Component) -> Int? {
        let dateComponents = Calendar.current.dateComponents([component], from: date, to: self)
        return dateComponents.value(for: component)
    }
    public func years(from date: Date) -> Int? {
        return offset(from: date, component: .year)
    }
    public func months(from date: Date) -> Int? {
        return offset(from: date, component: .month)
    }
    public func days(from date: Date) -> Int? {
        return offset(from: date, component: .day)
    }
    public func hours(from date: Date) -> Int? {
        return offset(from: date, component: .hour)
    }
    public func minutes(from date: Date) -> Int? {
        return offset(from: date, component: .minute)
    }
    public func seconds(from date: Date) -> Int? {
        return offset(from: date, component: .second)
    }
    public func weeks(from date: Date) -> Int? {
        return offset(from: date, component: .weekOfYear)
    }
}
extension Date {
    public func toString(withDateFormat format: String) -> String {
        let dateFormatter = DateFormatter(dateFormat: format)
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
}
