//
//  UserDefaultsExtension.swift
//  SWExtensions
//
//  Created by Seven on 21/6/2019.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation

extension UserDefaults {
    ///保存数据
    public static func save<T>(value:T,key:String) -> () {
        let userDefault = UserDefaults.standard
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    ///根据key获取数据
    public static func get<T>(key:String) -> T? {
        let userDefault = UserDefaults.standard
        if let ob = userDefault.object(forKey: key) {
            return ob as? T
        }else{
            return nil
        }
    }
}
