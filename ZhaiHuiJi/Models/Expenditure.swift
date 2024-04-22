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
final class Expenditure {
    var id: UUID = UUID()
    var count : Double = 0.0
    var datetime: Date = Date.now
    var kind : ExKind.RawValue = ExKind.gas.rawValue
    
    init(count: Double = 0.0, datetime: Date = Date.now, kind: ExKind.RawValue = ExKind.gas.rawValue) {
        self.count = count
        self.datetime = datetime
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
    var icon:String {
        switch self {
            case .gas:
                "gauge.with.dots.needle.bottom.50percent"
            case .water:
                "drop.degreesign.fill"
            case .electricity:
                "lightbulb.max"
        }
    }
}

enum TimeSpan:String, Identifiable, CaseIterable {
    case month, year, all
    var id: Self {
        self
    }
    
    var desc: String {
        switch self {
            case .month:
                "一月"
            case .year:
                "一年"
            case .all:
                "全部"
        }
    }
    
}
