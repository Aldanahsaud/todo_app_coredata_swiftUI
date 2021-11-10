//
//  ToDoHomework_2App.swift
//  ToDoHomework#2
//
//  Created by AlDanah Aldohayan on 07/11/2021.
//

import SwiftUI

@main
struct ToDoHomework_2App: App {
    let persistantContainer = CoreDataManagerr.shared.persistantContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
