//
//  watchInMRApp.swift
//  watchInMR
//
//  Created by Cleopatra on 2025/6/7.
//

import SwiftUI

@main
struct watchInMRApp: App {
    @StateObject
    var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionManager)
        }
    }
}
