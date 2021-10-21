//
//  AppDelegate.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.makeKeyAndVisible()
        return true
    }
}
extension AppDelegate {
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        CacheClearHelper.clearCache()
    }
}
