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
    var title:String?
}
extension HomeData {
    static func setupWithDatas(_ datas:[[String: Any]]?) -> [HomeData] {
        var result = [HomeData]()
        guard let values = [HomeData].deserialize(from: datas) else { return result }
        values.forEach { item in
            guard var item = item else { return }
            let content = item.content ?? ""
            if item.type == .textImg {
                let title = item.id == 3 ? "ArcBlock DevCon 2020" : item.id == 4 ? "ArcBlock ABT Node" : content
                item.title = title
            } else if item.type == .textLink {
                let title = item.id == 5 ? "ABT 钱包的官网" : content
                item.title = title
            }
            result.append(item)
        }
        return result
    }
}
