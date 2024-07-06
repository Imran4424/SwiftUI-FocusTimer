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
            Home()
                .environmentObject(focusModel)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FocusModel())
}
