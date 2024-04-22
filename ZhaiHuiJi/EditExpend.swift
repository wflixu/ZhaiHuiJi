//
//  EditExpend.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/4/22.
//

import Observation
import SwiftUI

struct EditExpend: View {
    @Bindable var expend: Expenditure
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Section {
                Form {
                    LabeledContent {
                        TextField("Count", value: $expend.count, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("值")
                    }.keyboardType(.decimalPad)
                        
                    Picker("种类:", selection: $expend.kind) {
                        ForEach(ExKind.allCases) { item in
                            Text(item.desc).tag(item.rawValue)
                        }
                    }
                        
                    DatePicker("日期时间:", selection: $expend.datetime, displayedComponents: [.date, .hourAndMinute])
                        
                    Button("更新记录", action: saveUpdate)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .buttonStyle(.borderedProminent)
                        .padding(.vertical)
                        .disabled(expend.count <= 0.0)
                        .navigationTitle("编辑记录")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            
        }.navigationTitle(Text("编辑"))
    }
    
    func saveUpdate() {
        try? modelContext.save()
        
        dismiss()
    }
}

#Preview {
    EditExpend(expend: Expenditure())
}
