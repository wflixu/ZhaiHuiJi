//
//  ZhaiHuiJiApp.swift
//  ZhaiHuiJi
//
//  Created by 李旭 on 2024/1/24.
//

import SwiftUI
import SwiftData

@main
struct ZhaiHuiJiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Expenditure.self,
        ])
        let modelConfiguration = ModelConfiguration("HouseFee",schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environment(\.locale, .init(identifier: "zh_CN"))
    }
    
}
