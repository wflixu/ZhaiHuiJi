//
//  Item.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
