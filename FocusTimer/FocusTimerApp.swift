//
//  FocusTimerApp.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    // MARK: - Since, we are doing background fetching. Initializing here
    @StateObject var focusModel: FocusModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(focusModel)
                .preferredColorScheme(.dark)
        }
    }
}
