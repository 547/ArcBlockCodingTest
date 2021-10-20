//
//  UIScreenExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/13.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIScreen {
    public static var size:CGSize {
        let result = UIScreen.main.bounds.size
        return result
    }
    public static var width:CGFloat {
        let result = UIScreen.size.width
        return result
    }
    public static var height:CGFloat {
        let result = UIScreen.size.height
        return result
    }
}
