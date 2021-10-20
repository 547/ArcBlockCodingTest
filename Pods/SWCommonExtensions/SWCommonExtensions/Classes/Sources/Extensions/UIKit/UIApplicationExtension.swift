//
//  UIApplicationExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/13.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIApplication {
    public var currentWindow: UIWindow? {
        guard keyWindow == nil else { return keyWindow }
        guard windows.last == nil else { return windows.last }
        guard delegate?.window == nil else { return (delegate?.window)! }
        return nil
    }
}

extension UIApplication {
    public var currentViewController: UIViewController? {
        var result:UIViewController? = nil
        guard let window = currentWindow, let rootViewController = window.rootViewController else { return result }
        result = getCurrentViewController(with: rootViewController)
        return result
    }
    public var currentNavigationController: UINavigationController? {
        var result:UINavigationController? = nil
        guard let viewController = currentViewController else { return result }
        result = getCurrentNavigationController(with: viewController)
        return result
    }
}
private extension UIApplication {
    func getCurrentViewController(with rootViewController:UIViewController) -> UIViewController? {
        var result:UIViewController? = nil
        let rootVC = rootViewController
        if let presentedViewController = rootVC.presentedViewController {
            result = getCurrentViewController(with: presentedViewController)
        }else if let tabBarController = rootVC as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            if let navigationController = selectedViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
                result = getCurrentViewController(with: visibleViewController)
            }else{
                result = selectedViewController
            }
        }else if let navigationController = rootVC as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            result = getCurrentViewController(with: visibleViewController)
        }else{
            result = rootVC
        }
        return result
    }
    func getCurrentNavigationController(with viewController:UIViewController) -> UINavigationController? {
        var result:UINavigationController? = nil
        if let navController = viewController.navigationController {
            result = navController
        }else if let navController = viewController.parent?.navigationController {
            result = navController
        }else if let navController = viewController as? UINavigationController {
            result = navController
        }
        return result
    }
}
