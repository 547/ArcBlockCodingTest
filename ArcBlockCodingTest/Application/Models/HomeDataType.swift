//
//  HomeDataType.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import Foundation
import HandyJSON
enum HomeDataType: String, HandyJSONEnum {
    case text = "text"
    case img = "img"
    case textImg = "text-img"
    case textLink = "text-link"
}
