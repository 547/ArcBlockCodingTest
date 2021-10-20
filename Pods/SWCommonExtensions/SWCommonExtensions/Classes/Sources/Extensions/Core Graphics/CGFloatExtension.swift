//
//  CGFloatExtension.swift
//  VTravel
//
//  Created by Seven on 27/6/2019.
//  Copyright © 2019 Seven. All rights reserved.
//

import UIKit

extension CGFloat {
    public var int: Int { return Int(self) }
    public var float: Float { return Float(self) }
    public var double: Double { return Double(self) }
    
    public var opposite: CGFloat { return -(self) }
    public var absolute: CGFloat { return abs(self) }
}
