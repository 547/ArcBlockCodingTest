//
//  NSObjectExtension.swift
//  VTravel
//
//  Created by Seven on 27/6/2019.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation

extension NSObject {
    public static var className: String { return String(describing: self) }
    public var className: String { return String(describing: self) }
}
