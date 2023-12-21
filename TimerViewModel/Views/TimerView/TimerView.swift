//
//  TimerView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI

struct TimerView: View {
    // MARK: - Properties
    
    /// The view model responsible for managing timer logic.
    @ObservedObject var viewModel: TimerViewModel
    
    /// A flag to control the display of the bubble effect.
    @State private var showBubbleEffect = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            
            // Main content of the timer view.
            VStack {
                Spacer()
                
                Text("Timer")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 50)
                
                TimerCircleView(viewModel: viewModel)
                
                Spacer()
                
                TimerControlsView(viewModel: viewModel)
                
                Spacer()
            }
            .background(Color.black.opacity(0.09))
            .ignoresSafeArea()
        }
        .onReceive(viewModel.timerEnded) { _ in
            // Handle timer ended event.
            print("Timer ended!")
            showBubbleEffect.toggle()
        }
        .overlay(
            Group {
                // Display the bubble effect again if the flag is true.
                if showBubbleEffect {
                    BubbleEffectView(replay: true)
                        .transition(.scale)
                        .animation(.easeInOut, value: 1.0)
                }
            }
        )
    }
}
