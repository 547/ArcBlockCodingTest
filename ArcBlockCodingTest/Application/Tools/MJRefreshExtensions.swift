//
//  MJRefreshExtensions.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import Foundation
import SW_MJRefresh
import MJRefresh
import SWLog
extension UIScrollView {
    func setRefreshView(refreshBlock:(() -> ())?,loadMoreBlock:(() -> ())?) -> (){
        if let refreshBlock = refreshBlock {
            let headView = MJRefreshNormalHeader.init(refreshingBlock: refreshBlock)
            headView.setTitle("drop down refresh", for: .idle)
            headView.setTitle("refreshing...", for: .refreshing)
            headView.setTitle("refresh immediately", for: .pulling)
            headView.lastUpdatedTimeLabel?.isHidden = true
            mj_header = headView
        }
        if let loadMoreBlock = loadMoreBlock {
            let footView = MJRefreshAutoNormalFooter.init(refreshingBlock: loadMoreBlock)
            footView.setTitle("drop up load more", for: .idle)
            footView.setTitle("loading...", for: .refreshing)
            footView.setTitle("load immediately", for: .pulling)
            footView.setTitle("load finshed", for: .noMoreData)
            mj_footer = footView
            mj_footer?.isHidden = true
        }
    }
}
