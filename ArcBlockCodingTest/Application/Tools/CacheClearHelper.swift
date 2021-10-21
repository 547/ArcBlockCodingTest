//
//  CacheClearHelper.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/21.
//

import Foundation
import WebKit
import SWLog
class CacheClearHelper {}
extension CacheClearHelper {
    /// 删除app的所有缓存
    static func clearCache() {
        clearAppCache()
        clearWebCache()
    }
    /// 删除app的缓存除了webview的缓存
    static func clearAppCache() {
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first,
        let subpaths = FileManager.default.subpaths(atPath: cachePath) else {
            return
        }
        subpaths.forEach { item in
            let path = cachePath + "/" + item
            if FileManager.default.fileExists(atPath: path) {
                try? FileManager.default.removeItem(atPath: path)
            }
        }
   }
    
    /// 删除webview的缓存
    static func clearWebCache () -> () {
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: date) {
            SWLog.debug("删除web view缓存成功")
        }
        WKWebsiteDataStore.nonPersistent().removeData(ofTypes: websiteDataTypes, modifiedSince: date) {
            SWLog.debug("删除web view缓存成功")
        }
    }
}
