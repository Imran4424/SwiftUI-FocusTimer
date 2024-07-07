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
    @StateObject var stopwatchModel: StopWatchModel = .init()
    
    // MARK: - Scene phase
    @Environment(\.scenePhase) var phase
    
    // MARK: - storing last time stamp
    @State var lastActiveTimeStamp: Date = Date()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(focusModel)
                .environmentObject(stopwatchModel)
                .preferredColorScheme(.dark)
        }
        .onChange(of: phase) { oldValue, newValue in
            if focusModel.isStarted {
                if newValue == .background {
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active {
                    // MARK: - finding the difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    
                    if stopwatchModel.isRunning {
                        stopwatchModel.totalSeconds += Int(currentTimeStampDiff)
                    }
                    
                    if focusModel.totalSeconds - Int(currentTimeStampDiff) <= 0 {
                        focusModel.isStarted = false
                        focusModel.totalSeconds = 0
                        focusModel.isFinished = true
                    } else {
                        focusModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
    }
}
