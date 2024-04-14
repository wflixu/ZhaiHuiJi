//
//  Item.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Expenditure {
    var count : Double = 0.0
    var created: Date = Date.now
    var kind : ExKind.RawValue = ExKind.gas.rawValue
    
    init(count: Double = 0.0, created: Date = Date.now, kind: ExKind.RawValue = ExKind.gas.rawValue) {
        self.count = count
        self.created = created
        self.kind = kind
    }
    
}


enum ExKind: Int, Codable, Identifiable, CaseIterable {
    case gas = 1, water, electricity
    var id: Self {
        self
    }
    var desc: String {
        switch self {
            case .gas:
                "气"
            case .water:
                "水"
            case .electricity:
                "电"
        }
    }
}
