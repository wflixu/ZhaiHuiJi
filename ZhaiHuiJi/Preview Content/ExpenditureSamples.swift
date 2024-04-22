//
//  ExpenditureSamples.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/25.
//

import Foundation

extension Expenditure {
    static var sampleExpenditures: [Expenditure] {
        [
            Expenditure(count: 100,  datetime: Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!, kind: ExKind.gas.rawValue),
            Expenditure(count: 111, datetime: Calendar.current.date(byAdding: .day, value: -6, to: Date.now)!, kind: ExKind.gas.rawValue ),
            Expenditure(count: 116, datetime: Calendar.current.date(byAdding: .day, value: -5, to: Date.now)!, kind: ExKind.gas.rawValue ),
            Expenditure(count: 126, datetime: Calendar.current.date(byAdding: .day, value: -3, to: Date.now)!, kind: ExKind.gas.rawValue ),
            Expenditure(count: 137, datetime: Calendar.current.date(byAdding: .day, value: -3, to: Date.now)!, kind: ExKind.water.rawValue ),
            Expenditure(count: 209, datetime: Calendar.current.date(byAdding: .day, value: -2, to: Date.now)!, kind: ExKind.water.rawValue ),
        ]
    }
}
