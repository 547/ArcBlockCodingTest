//
//  DateFormatterExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/28.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import Foundation

extension DateFormatter {
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
