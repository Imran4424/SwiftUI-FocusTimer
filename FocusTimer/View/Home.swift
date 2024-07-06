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
                    // MARK: - Timer Ring
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
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: focusModel.progress)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeOut, value: focusModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button {
                        if focusModel.isStarted {
                            focusModel.stopTimer()
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
        .overlay {
            ZStack {
                Color.black
                    .opacity(focusModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        focusModel.hours = 0
                        focusModel.minutes = 0
                        focusModel.seconds = 0
                        focusModel.addNewTimer = false
                    }
                
                NewTimerView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: focusModel.addNewTimer ? 0 : 400)
            }
            .animation(.easeInOut, value: focusModel.addNewTimer)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if focusModel.isStarted {
                focusModel.updateTimer()
            }
        }
    }
    
    // MARK: - New Timer Bottom Sheet
    @ViewBuilder
    func NewTimerView() -> some View {
        VStack(spacing: 15) {
            Text("Add New Timer")
                .font(.title2.bold())
                .foregroundStyle(Color.white)
                .padding(.top, 10)
            
            HStack(spacing: 15) {
                Text("\(focusModel.hours) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white.opacity(0.07))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(Color.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 12, hint: "hr") { value in
                            focusModel.hours = value
                        }
                    }
                
                Text("\(focusModel.minutes) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white.opacity(0.07))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(Color.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 60, hint: "min") { value in
                            focusModel.minutes = value
                        }
                    }
                
                Text("\(focusModel.seconds) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white.opacity(0.07))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(Color.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 60, hint: "sec") { value in
                            focusModel.seconds = value
                        }
                    }
            }
            .padding(.top, 20)
            
            Button {
                focusModel.startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background {
                        Capsule()
                            .fill(Color("mPurple"))
                    }
            }
            .disabled(focusModel.seconds == 0)
            .opacity(focusModel.seconds == 0 ? 0.5 : 1)
            .padding(.top)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("BG"))
                .ignoresSafeArea()
            
        }
    }
    
    // MARK: - Reusable context menu options
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int) -> ()) -> some View {
        ForEach(0...maxValue, id: \.self) { value in
            Button {
                onClick(value)
            } label: {
                Text("\(value) \(hint)")
            }
        }
    }
}

#Preview {
    Home()
        .environmentObject(FocusModel())
        .preferredColorScheme(.dark)
}
