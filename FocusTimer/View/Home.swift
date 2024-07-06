//
//  Home.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var focusModel: FocusModel
    
    var body: some View {
        VStack {
            Text("Focus Timer")
                .font(.title2.bold())
                .foregroundStyle(Color.white)
            
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    // MARK: - Timer
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.03))
                            .padding(-40)
                        
                        Circle()
                            .trim(from: 0, to: focusModel.progress)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        
                        // MARK: - Shadow
                        Circle()
                            .stroke(Color("mPurple"), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: focusModel.progress)
                            .stroke(Color("mPurple").opacity(0.7), lineWidth: 10)
                        
                        // MARK: - Knob
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("mPurple"))
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                // since view is rotated, that's why using x
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: focusModel.progress * 360))
                            
                        }
                        
                        Text(focusModel.timerStringValue)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: -90))
                            .animation(.none, value: focusModel.progress)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeOut, value: focusModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button {
                        if focusModel.isStarted {
                            
                        } else {
                            focusModel.addNewTimer = true
                        }
                        
                    } label: {
                        Image(systemName: focusModel.isStarted ? "pause" : "timer")
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
    Home()
        .environmentObject(FocusModel())
        .preferredColorScheme(.dark)
}
