//
//  ExpenditureListView.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/24.
//

import SwiftData
import SwiftUI

struct ExpenditureListView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var expenditures: [Expenditure]
    
    init(filterKind: Int = 1, span: TimeSpan = TimeSpan.month) {
        print("timespan in list \(span.desc): \(span.rawValue)")
        var predicate: Predicate<Expenditure>
        if span == TimeSpan.all {
            predicate = #Predicate<Expenditure> { expend in
                expend.kind == filterKind
            }
        } else {
            let timespanAgo = Calendar.current.date(byAdding: span == TimeSpan.month ? .month : .year, value: -1, to: .now)!
            predicate = #Predicate<Expenditure> { expend in
                expend.kind == filterKind && expend.datetime >= timespanAgo
            }
        }
        _expenditures = Query(filter: predicate, sort: \.datetime, order: .reverse)
    }


    var body: some View {
        Group {
            if expenditures.isEmpty {
                ContentUnavailableView("请添加记录", systemImage: "dollarsign.square")
            } else {
                List {
                    ForEach(expenditures) { expend in
                       
                        HStack {
                            Image(systemName: ExKind(rawValue: expend.kind)!.icon).resizable().frame(width: 32, height: 32)
                            
                            NavigationLink {
                                EditExpend(expend: expend)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("\(expend.count.fixed())")
                                    Text("\(formatterDate(date: expend.datetime))")
                                }
                            }
                        }
                    }.onDelete { indexSet in
                        for index in indexSet {
                            let expend = expenditures[index]
                            context.delete(expend)
                        }
                    }
                }.listStyle(.plain)
            }
        }
    }
    
    func formatterDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ExpenditureListView().modelContainer(for: Expenditure.self, inMemory: true)
}
