//
//  Home.swift
//  FocusTimer
//
//  Created by Shah Md Imran Hossain on 6/7/24.
//

import SwiftUI

struct Home: View {
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
                            .trim(from: 0, to: 0.5)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        
                        // MARK: - Shadow
                        Circle()
                            .stroke(Color("Purple"), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .stroke(Color("Purple").opacity(0.7), lineWidth: 10)
                        
                        // MARK: - Knob
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("Purple"))
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                // since view is rotated, that's why using x
                                .offset(x: size.height / 2)
                            
                        }
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
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
