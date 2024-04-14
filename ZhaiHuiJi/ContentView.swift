//
//  ContentView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var createExpend = false
    @State private var curKind = ExKind.gas
    var body: some View {
        NavigationStack {
            ScrollView {
                DashboardView(kindRv: curKind.rawValue).frame(height: 300)
                HStack {
                    Picker("类型", selection: $curKind) {
                        ForEach(ExKind.allCases) { exKind in
                            Text("\(exKind.desc)").tag(exKind)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                ExpenditureListView(filterKind: curKind.rawValue).frame(height: 500)
            }

            .padding()
            .navigationTitle("家庭支出")
            .toolbar {
                Button {
                    createExpend = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createExpend) {
                NewExpendView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Expenditure.self, inMemory: true)
}
