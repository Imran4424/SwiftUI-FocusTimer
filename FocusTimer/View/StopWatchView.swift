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
                    ZStack {
                        Circle()
                            .fill(Color("BG"))
                            .padding(-40)
                        
                        Circle()
                            .stroke(Color("mPurple").opacity(0.7), lineWidth: 15)
                            .padding(-40)
                        
                        // MARK: - Shadow
                        Circle()
                            .stroke(Color("mPurple"), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-15)
                        
                        Text(stopWatchModel.watchStringValue)
                            .font(.system(size: 45, weight: .light))
//                            .rotationEffect(.init(degrees: 90))
//                            .animation(.none, value: focusModel.progress)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.largeTitle.bold())
                                .foregroundStyle(Color.white)
                                .frame(width: 80, height: 80)
                                .background {
                                    Circle()
                                        .fill(Color("DarkPurple"))
                                }
                                .shadow(color: Color("mPurple"), radius: 8, x: 0, y: 0)
                        }
                        
                        Spacer()

                        Button {
                            
                        } label: {
                            Image(systemName: stopWatchModel.isStarted ?  "pause" : "play")
                                .font(.largeTitle.bold())
                                .foregroundStyle(Color.white)
                                .frame(width: 80, height: 80)
                                .background {
                                    Circle()
                                        .fill(Color("DarkPurple"))
                                }
                                .shadow(color: Color("mPurple"), radius: 8, x: 0, y: 0)
                        }
                    }
                    .padding(.horizontal)
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
