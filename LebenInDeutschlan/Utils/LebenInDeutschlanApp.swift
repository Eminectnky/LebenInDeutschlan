//
//  LebenInDeutschlanApp.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 15.04.2024.
//

import SwiftUI

@main
struct LebenInDeutschlanApp: App {
    @StateObject var appState = AppState() 
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(appState)
        }
    }
}
