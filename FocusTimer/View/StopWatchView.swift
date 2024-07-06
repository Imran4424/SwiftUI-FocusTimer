//
//  StopWatchView.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

struct StopWatchView: View {
    @EnvironmentObject var stopWatchModel: StopWatchModel
    
    var body: some View {
        VStack {
            Text("Stopwatch")
                .font(.title2.bold())
                .foregroundStyle(Color.white)
            
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    // MARK: - Timer Ring
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    StopWatchView()
        .environmentObject(StopWatchModel())
        .preferredColorScheme(.dark)
}
