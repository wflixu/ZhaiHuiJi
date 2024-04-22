//
//  DashboardView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/25.
//

import Charts
import SwiftData
import SwiftUI
import SwiftUICharts

struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @State var kindRv: ExKind = .gas
    @State private var data: [Expenditure] = []

    @Query private var expenditures: [Expenditure]
    @State private var rawSelectedDate: String?
    @State private var selectedRange: ClosedRange<String>?

    @State private var scrollPosition: Date = Date.now.addingTimeInterval(-1 * 3600 * 24 * 30)

    let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH" // 设置日期格式为"年月日"
        return dateFormatter
    }()

    init(filterKind: Int = 1) {
        let predicate = #Predicate<Expenditure> { expend in
            expend.kind == filterKind
        }
        _expenditures = Query(filter: predicate, sort:\.created, order:.reverse )
    }

    var ave: String {
        print("ave....")
        if let index = expenditures.firstIndex(where: { exp in

            dateFormatter.string(from: exp.created) == rawSelectedDate

        }) {
            if index == 0 {
                return "start"
            } else {
                let previousExpend = expenditures[index - 1]
                let expend = expenditures[index]

                let diff = expend.count - previousExpend.count
                let span = expend.created.timeIntervalSince(previousExpend.created) / (60 * 60 * 24)
                print(span)
                let avd = diff / Double(span)
                return String(format: "%.2f", avd)
            }
        } else {
            return "no"
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text(scrollPosition.description)
            }
            Chart {
                ForEach(self.expenditures) { expend in

                    LineMark(
                        x: .value("Day", expend.created, unit: .day),
                        y: .value("Value", expend.count)
                    )

                    BarMark(
                        x: .value("Day", expend.created, unit: .day),
                        y: .value("Value2", getAvd(expend)),
                        width: 20
                    ).annotation { _ in
                        Text(getAvdStr(expend))
                    }
                }
                if let rawSelectedDate {
                    RuleMark(
                        x: .value("Selected", rawSelectedDate)
                    )
                    .foregroundStyle(Color.red)
                    .offset(yStart: 40)
                    .zIndex(1)
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(
                        x: .fit(to: .automatic),
                        y: .disabled

                    )) {
                        valueSelectionPopover()
                    }
                }
            }
            .foregroundStyle(.blue)
            .chartXSelection(value: $rawSelectedDate)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * 30 * 6)
            .chartScrollPosition(x: $scrollPosition)
//            .chartScrollTargetBehavior(
//                .valueAligned(
//                    matching: .init(hour: 0),
//                    majorAlignment: .matching(.init(day: 1))
//                ))
//           
//            .chartYAxis {
//                AxisMarks(position: .leading, values: .stride(by: 2)) {
//                    AxisTick()
//         
//                    AxisValueLabel()
//                }
//                AxisMarks(position: .trailing, values: .automatic(desiredCount: 8)) {
//                    AxisTick()
//                   
//                    AxisValueLabel()
//                }
//            }

        }.padding([.top], 40)
    }

    func areDatesOnSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)

        return components1.year == components2.year &&
            components1.month == components2.month &&
            components1.day == components2.day
    }

    func valueSelectionPopover() -> some View {
        VStack {
            Text("平均每天").font(.title3)
            Text(ave).font(.title3)
        }
        .padding(8)
        .background(Color.blue.opacity(0.6))
        .cornerRadius(4)
    }

    // MARK: - Private Methods

    // 根据当前expend 查找 在 expenditures 中的 index
    // 如果是第一个，返回 空字符串，
    // 否则 再找到前一个expenditure, 计算差值
    // 计算差值的平均日增长率
    // 返回 平均日增长率格式化的字符串
    func getAvd(_ expend: Expenditure) -> Double {
        if let i = expenditures.firstIndex(where: { $0 == expend }) {
            if i == 0 {
                return 0.0
            } else {
                let previousExpend = expenditures[i - 1]
                let diff = expend.count - previousExpend.count
                let span = expend.created.timeIntervalSince(previousExpend.created)
                let avd = diff / Double(span) * 60 * 60 * 24
                return avd
            }
        } else {
            return 0.0
        }
    }

    func getAvdStr(_ expend: Expenditure) -> String {
        if let i = expenditures.firstIndex(where: { $0 == expend }) {
            if i == 0 {
                return "0"
            } else {
                let previousExpend = expenditures[i - 1]
                let diff = expend.count - previousExpend.count
                let span = expend.created.timeIntervalSince(previousExpend.created)
                let avd = diff / Double(span) * 60 * 60 * 24
                return String(format: "%.2f", avd)
            }
        } else {
            return "0.0"
        }
    }
}

#Preview {
    let preview = PreviewWrapper(Expenditure.self)
    preview.addExamples(Expenditure.sampleExpenditures)
    return NavigationStack {
        DashboardView(filterKind: ExKind.gas.rawValue)
    }
    .modelContainer(preview.container)
}
