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
    @Published var isStarted: Bool = false
    
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: - total seconds
    @Published var totalSeconds: Int = 0
}
