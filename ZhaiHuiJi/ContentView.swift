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
    @State private var timespan = TimeSpan.month

    var body: some View {
        NavigationStack {
            HStack {
                GeometryReader { geometry in
                    Picker("类型", selection: $timespan) {
                        ForEach(TimeSpan.allCases) { tp in
                            Text("\(tp.desc)")
                                .tag(tp)
                        }
                    }

                    .pickerStyle(.segmented)
                    .frame(width: geometry.size.width, height: 50)
                }
            }.frame(height: 50)

            ScrollView {
                DashboardView(filterKind: curKind.rawValue, span: timespan).frame(height: 300)

                HStack {
                    GeometryReader { geometry in
                        Picker("类型", selection: $curKind) {
                            ForEach(ExKind.allCases) { exKind in
                                Text("\(exKind.desc)")
                                    .tag(exKind)
                            }
                        }

                        .pickerStyle(.segmented)
                        .frame(width: geometry.size.width, height: 50)
                    }
                }.frame(height: 50)

                Divider()

                ExpenditureListView(filterKind: curKind.rawValue, span: timespan).frame(height: 500)
            }

            .padding()
//            .navigationBarTitle(
//                Text("").font(.title2)
//            )
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
