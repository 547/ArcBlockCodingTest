//
//  SWLog.swift
//  FBSnapshotTestCase
//
//  Created by SSD on 2019/9/3.
//

import Foundation

public class SWLog {}

public extension SWLog {
    static func debug(_ message:String) -> () {
        #if DEBUG
        print(message)
        #endif
    }
}
public extension SWLog {
    static func log(_ message: String) {
        debug("[\(Date())]\n\(message)\n")
    }
    static func log<T>(_ value: T) {
        debug("[\(Date())]\n\(value)\n")
    }
}
