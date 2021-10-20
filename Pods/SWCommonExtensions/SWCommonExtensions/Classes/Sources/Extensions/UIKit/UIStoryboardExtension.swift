//
//  UIStoryboardExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIStoryboard {
    public static func instantiateViewController<T>(fromStoryboard named: String, bundle: Bundle = Bundle.main, withClass type: AnyClass) -> T? {
        let storyboard = UIStoryboard(name: named, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
}
