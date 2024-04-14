//
//  DashboardView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/25.
//

import Charts
import SwiftUI
import SwiftData


struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @State private var kindRv: ExKind.RawValue = 1
   
    @Query()  var expenditures: [Expenditure]
    
 
    init(kindRv: ExKind.RawValue = 1) {
        self.kindRv = kindRv
    
    }
    
    var body: some View {
        Chart {
            ForEach(expenditures) { expend in
                LineMark(
                    x: .value("Day", expend.created.ISO8601Format()),
                    y: .value("Value", expend.count)
                ).annotation(position: .overlay) {
                    Text(String(expend.count))
                }.foregroundStyle(by: .value("Kind", expend.kind))
            }
        }.padding()
    }
}

#Preview {
    let preview = PreviewWrapper(Expenditure.self)
    preview.addExamples(Expenditure.sampleExpenditures)
    return NavigationStack {
        DashboardView(kindRv: 1)
    }
    .modelContainer(preview.container)
    
}
