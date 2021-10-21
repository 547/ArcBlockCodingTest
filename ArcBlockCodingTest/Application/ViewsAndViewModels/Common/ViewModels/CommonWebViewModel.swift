//
//  CommonWebViewModel.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/21.
//

import Foundation
import SWCommonExtensions
class CommonWebViewModel {
    var urlString:String? {
        didSet {
            guard let value = urlString, value.isUrl() else {
                url = nil
                return
            }
            url = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        }
    }
    private (set) var url:String?
    var navigationTitle:String?
}
