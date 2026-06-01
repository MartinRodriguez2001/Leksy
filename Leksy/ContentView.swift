//
//  ContentView.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 25-05-26.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @AppStorage("hasCompletedSetup") private var hasCompletedSetup: Bool = false
    @AppStorage("hasCompletedLanguageDownload") private var hasCompletedLanguageDownload: Bool = false
    @AppStorage("hasCompletedCardCreation") private var hasCompletedCardCreation: Bool = false

    init() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

        var body: some View {
            Group {
                if !hasCompletedSetup {
                    LanguageSetupView(onSetupComplete: {
                        hasCompletedSetup = true
                    })
                } else if !hasCompletedLanguageDownload {
                    LanguageDownloadView(onComplete: {
                        triggerHaptic(style: .medium)
                        hasCompletedLanguageDownload = true
                    })
                } else if !hasCompletedCardCreation {
                    CreateCardsScreen(onComplete: {
                        triggerHaptic(style: .medium)
                        hasCompletedCardCreation = true
                    })
                } else {
                    HomeScreen()
                }
            }
            .animation(.default, value: hasCompletedSetup)
            .animation(.default, value: hasCompletedLanguageDownload)
            .animation(.default, value: hasCompletedCardCreation)
        }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
