//
//  NumberExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

public typealias Byte = UInt8

extension Int {
    public var string:     String  { return "\(self)"          }
    public var cgfloat:    CGFloat { return CGFloat(self)      }
    public var float:      Float   { return Float(self)        }
    public var double:     Double  { return Double(self)       }
    public var byte:       Byte    { return Byte(self)         }
    public var opposite:   Int     { return -self              }
    public var absolute:   Int     { return abs(self)          }
}
extension Float {
    public var string:     String  { return "\(self)"          }
    public var cgfloat:    CGFloat { return CGFloat(self)      }
    public var int:        Int     { return Int(self)          }
    public var roundedInt: Int     { return Int(roundf(self))  }
    public var double:     Double  { return Double(self)       }
    public var opposite:   Float   { return -self              }
    public var absolute:   Float   { return abs(self)          }
}
extension Double {
    public var string:     String  { return "\(self)"      }
    public var cgfloat:    CGFloat { return CGFloat(self)  }
    public var int:        Int     { return Int(self)      }
    public var float:      Float   { return Float(self)    }
    public var opposite:   Double  { return -self          }
    public var absolute:   Double  { return abs(self)      }
}
extension Byte {
    public var string:     String  { return "\(self)"      }
    public var cgfloat:    CGFloat { return CGFloat(self)  }
    public var int:        Int     { return Int(self)      }
}

extension Int {
    public subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex { decimalBase *= 10 }
        return (self / decimalBase) % 10
    }
}
