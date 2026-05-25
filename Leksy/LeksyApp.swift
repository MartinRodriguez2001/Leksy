//
//  LeksyApp.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 25-05-26.
//

import SwiftUI
import CoreData

@main
struct LeksyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
