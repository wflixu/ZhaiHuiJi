//
//  ChartsDemoView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/4/16.
//

import Charts
import SwiftUI

struct MonthlyHoursOfSunshine :Identifiable {
    var date: Date
    let id = UUID()
    var hoursOfSunshine: Double

    init(month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}

struct ChartsDemoView: View {
    var data: [MonthlyHoursOfSunshine] = [
        MonthlyHoursOfSunshine(month: 1, hoursOfSunshine: 74),
        MonthlyHoursOfSunshine(month: 2, hoursOfSunshine: 99),
        // ...
        MonthlyHoursOfSunshine(month: 12, hoursOfSunshine: 62)
    ]

    var body: some View {
        VStack {
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
            }
        }
    }
}

#Preview {
    ChartsDemoView()
}
