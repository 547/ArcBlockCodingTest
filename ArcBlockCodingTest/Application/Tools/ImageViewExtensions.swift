//
//  ImageViewExtensions.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit
import Kingfisher
extension UIImageView {
    func setImage(_ url:String, placeholder: UIImage? = nil) -> () {
        let url = URL.init(string: url)
        kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
