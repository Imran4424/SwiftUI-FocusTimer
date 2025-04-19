//
//  FocusModel.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

class FocusModel: NSObject, ObservableObject {
    // MARK: - Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: - total seconds
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    // MARK: - Post Timer Properties
    @Published var isFinished: Bool = false
    
    // Since Its NSObject
    override init() {
        super.init()
        self.authorizeNotification()
    }
    
    // MARK: - Requesting Notification Access
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // MARK: - to show in app notification
            UNUserNotificationCenter.current().delegate = self
        }
    }
    
    // MARK: - Starting timer
    func startTimer() {
        withAnimation(.easeIn(duration: 0.25)) {
            isStarted = true
        }
        
        timerStringValue = "\(hours == 0 ? "" : "\(hours):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        // calculating totals seconds for timer animations
        totalSeconds = hours * 3600 + minutes * 60 + seconds
        staticTotalSeconds = totalSeconds
        
        addNewTimer = false
        addNotification()
    }
    
    // MARK: - stoping timer
    func stopTimer() {
        withAnimation {
            isStarted = false
            hours = 0
            minutes = 0
            seconds = 0
            progress = 1
        }
        
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    // MARK: - updating timer
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        
        // 60 minutes * 60 seconds
        hours = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = totalSeconds % 60
        
        timerStringValue = "\(hours == 0 ? "" : "\(hours):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        if hours == 0 && minutes == 0 && seconds == 0 {
            isStarted = false
            print("Finished")
            isFinished = true
        }
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Focus Timer"
        content.subtitle = "Congratulations, You did it hooray 🥳🥳🥳"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}

extension FocusModel: UNUserNotificationCenterDelegate { 
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
}
