//
//  ViewControllerCenter.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit
class ViewControllerCenter {
}
// MARK: Common
extension ViewControllerCenter {
    static func getCommonWebViewController() -> CommonWebViewController? {
        let result:CommonWebViewController? = CommonWebViewController()
        return result
    }
}
// MARK: Home
extension ViewControllerCenter {
    static func getArcBlockDevCon2020TableViewController() -> ArcBlockDevCon2020TableViewController? {
        var result:ArcBlockDevCon2020TableViewController? = nil
        guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArcBlockDevCon2020TableViewController") as? ArcBlockDevCon2020TableViewController else { return result }
        result = viewController
        return result
    }
    static func getArcBlockABTNodeTableViewController() -> ArcBlockABTNodeTableViewController? {
        var result:ArcBlockABTNodeTableViewController? = nil
        guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArcBlockABTNodeTableViewController") as? ArcBlockABTNodeTableViewController else { return result }
        result = viewController
        return result
    }
}
