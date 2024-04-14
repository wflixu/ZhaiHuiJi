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

    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("Count", value: $count, formatter: NumberFormatter())
                } label: {
                    Text("Count:")
                }.keyboardType(.decimalPad)
                
                Picker("Kind:",selection: $kind) {
                    ForEach(ExKind.allCases) { item in
                        Text(item.desc).tag(item.rawValue)
                    }
                }
                Button("Create") {
                    let newExpend = Expenditure(count: count, kind: kind)
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
                        Button("Cancel") {
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
