//
//  NewExpendView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/25.
//

import SwiftUI

struct NewExpendView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    @State private var count = 0.0
    @State private var kind = ExKind.gas.rawValue
    @State private var datetime = Date.now

    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("Count", value: $count, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("值:")
                }.keyboardType(.decimalPad)
                
                Picker("种类:",selection: $kind) {
                    ForEach(ExKind.allCases) { item in
                        Text(item.desc).tag(item.rawValue)
                    }
                }
                
                DatePicker("日期时间:", selection: $datetime, displayedComponents: [.date, .hourAndMinute])
                
                Button("添加记录") {
                    let newExpend = Expenditure(count: count, datetime: datetime, kind: kind)
                    context.insert(newExpend)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(count <= 0.0)
                .navigationTitle("新记录")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("取消") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewExpendView()
}
