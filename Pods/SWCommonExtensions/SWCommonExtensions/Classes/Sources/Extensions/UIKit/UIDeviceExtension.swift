//
//  UIDeviceExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/16.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

extension UIDevice {
    public enum ModelType: String {
        case simulator, undefined
        
        init(identifier: String) {
            switch identifier {
            case "i386", "x86_64": self = .simulator
            default: self = .undefined
            }
        }
    }
    
    public static var device: ModelType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return ModelType(identifier: identifier)
    }
    
    public static var isSimulator: Bool { return device == .simulator }
}
