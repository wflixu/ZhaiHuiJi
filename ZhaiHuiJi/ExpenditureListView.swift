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
    
    init(filterKind: Int = 1) {
     
        let predicate = #Predicate<Expenditure> { expend in
            expend.kind == filterKind
        }
        _expenditures = Query(filter: predicate)
    }
    var body: some View {
        Group {
            if expenditures.isEmpty {
                ContentUnavailableView("Enter your first expenditure.", systemImage: "dollarsign.square")
            } else {
                List {
                    ForEach(expenditures) { expend in
                       
                        HStack {
                            Image(systemName: ExKind(rawValue: expend.kind)!.icon)
                            Text("\(expend.count.fixed())")
                            Text("\(formatterDate(date: expend.created))")
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
