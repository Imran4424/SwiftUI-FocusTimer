//
//  ContentView.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var focusModel: FocusModel
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .environmentObject(focusModel)
                    .tabItem {
                        Image(systemName: "clock.badge.fill")
                        Text("Timer")
                    }
                
                Text("Stopwatch")
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
}
