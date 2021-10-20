//
//  HomeData.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import Foundation
import HandyJSON
struct HomeData: HandyJSON {
    var id:Int = -1
    var type:HomeDataType = .text
    var content:String?
    var imgUrls:[String]?
    var link:String?
}
extension HomeData {
    static func setupWithDatas(_ datas:[[String: Any]]?) -> [HomeData] {
        var result = [HomeData]()
        guard let values = [HomeData].deserialize(from: datas) else { return result }
        let newResult = values.compactMap { item in
            return item
        }
        result.append(contentsOf: newResult)
        return result
    }
}
