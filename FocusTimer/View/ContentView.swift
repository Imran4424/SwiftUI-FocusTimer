//
//  ContentView.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var focusModel: FocusModel
    @EnvironmentObject var stopWatchModel: StopWatchModel
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                // environment object can be pushed once from app file
                // and used everywhere
                // no need to push again to child views
//                    .environmentObject(focusModel)
                    .tabItem {
                        Image(systemName: "clock.badge.fill")
                        Text("Timer")
                    }
                
                StopWatchView()
                // environment object can be pushed once from app file
                // and used everywhere
                // no need to push again to child views
//                    .environmentObject(stopWatchModel)
                    .tabItem {
                        Image(systemName: "stopwatch.fill")
                        Text("Stop watch")
                    }
                
                Text("Profile")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FocusModel())
        .environmentObject(StopWatchModel())
}
