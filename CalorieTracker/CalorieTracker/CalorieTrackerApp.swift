//
//  CalorieTrackerApp.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

@main
struct CalorieTrackerApp: App {
    @StateObject private var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
                .environment(\.locale, languageManager.locale)
        }
    }
}
