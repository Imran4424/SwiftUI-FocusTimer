//
//  StopWatchModel.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

class StopWatchModel: NSObject, ObservableObject {
    // MARK: - Stopwatch properties
    @Published var watchStringValue = "00:00:00"
    @Published var isRunning: Bool = false
    
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: - total seconds
    @Published var totalSeconds: Int = 0
    
    // MARK: - Methods
    // MARK: - Start
    func startTimer() {
        withAnimation(.easeIn(duration: 0.25)) {
            isRunning = true
        }
        
        watchStringValue = "\(hours >= 10 ? "\(hours)" : "0\(hours)"):\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        totalSeconds = 0
    }
    
    // MARK: - Stop timer
    func stopTimer() {
        withAnimation {
            isRunning = false
            hours = 0
            minutes = 0
            seconds = 0
        }
        
        totalSeconds = 0
        watchStringValue = "00:00:00"
    }
    
    // MARK: - updating timer
    func updateTimer() {
        if !isRunning {
            return
        }
        
        totalSeconds += 1
        
        // 60 minutes * 60 seconds
        hours = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = totalSeconds % 60
        
        watchStringValue = "\(hours >= 10 ? "\(hours)" : "0\(hours)"):\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
    }
}
