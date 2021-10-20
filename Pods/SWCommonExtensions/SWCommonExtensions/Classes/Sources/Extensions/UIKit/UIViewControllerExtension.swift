//
//  UIViewControllerExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/6.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UIViewController {
    public var isRootViewController: Bool{
        var result = false
        if let _ = navigationController, let viewControllers = navigationController?.viewControllers, viewControllers.count > 0, viewControllers[0].description == self.description{
            result = true
        }
        return result
    }
}

extension UIViewController {
    /// 隐藏下一个页面的导航栏返回按钮的标题
    public func hideBackButtonItemTitleForNextViewController(_ boolean: Bool) {
        if boolean {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        } else {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        }
    }
}

extension UIViewController {
    ///导航栏 + 状态栏高度
    public var topBarHeight:CGFloat{
        return (navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height
    }
    ///导航栏高度
    public var navigationBarHeight:CGFloat{
        return navigationController?.navigationBar.frame.height ?? 0
    }
    ///状态栏高度
    public var statusBarHeight:CGFloat{
        return UIApplication.shared.statusBarFrame.height
    }
    ///tabBar高度
    public var tabBarHeight:CGFloat{
        return tabBarController?.tabBar.bounds.height ?? 0
    }
    ///tabBar高度 + safeAreaInsets.bottom(PS:只有在viewDidAppear之后safeAreaInsets才有正确的值)
    public var bottomBarHeight:CGFloat{
        return tabBarHeight + safeAreaBottom
    }
}
extension UIViewController {
    /// safeAreaInsets(PS:只有在viewDidAppear之后safeAreaInsets才有正确的值)
    public var safeAreaInsets:UIEdgeInsets {
        var result = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            result = view.safeAreaInsets
        }
        return result
    }
    /// safeAreaInsets.bottom(PS:只有在viewDidAppear之后safeAreaInsets才有正确的值)
    public var safeAreaBottom:CGFloat {
        return safeAreaInsets.bottom
    }
    /// safeAreaInsets.bottom(PS:只有在viewDidAppear之后safeAreaInsets才有正确的值)
    public var safeAreaTop:CGFloat {
        return safeAreaInsets.top
    }
}
