//
//  HomeViewModel.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import Foundation
typealias ErrorCallback = (_ error: NSError?) -> ()
class HomeViewModel {
    var datas = [HomeData]()
}

extension HomeViewModel {
    func refresh(_ callback: ErrorCallback? = nil) -> () {
        var error:NSError? = nil {
            didSet {
                callback?(error)
            }
        }
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            error = NSError(domain: "data.json no found", code: 0, userInfo: nil)
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                datas = HomeData.setupWithDatas(json["data"] as? [[String : Any]])
                error = datas.count > 0 ? nil : NSError(domain: "empty data", code: 0, userInfo: nil)
            }
        } catch let err {
            error = err as NSError
        }
    }
}
