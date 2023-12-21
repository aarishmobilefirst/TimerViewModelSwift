//
//  TimerControlsView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI

// MARK: - TimerControlsView
struct TimerControlsView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            // Start/Resume/Pause Button
            TimerButton(label: buttonLabel, action: {
                if viewModel.isRunning {
                    updateButtonLabel()
                    viewModel.pauseTimer()
                } else {
                    viewModel.isRunning.toggle()
                }
            })
            
            // Stop Button
            TimerButton(label: "Stop", action: {
                updateButtonLabel()
                viewModel.stopTimer()
            })
            
            Spacer()
        }
        .onReceive(viewModel.timerEnded) { _ in
            print("Timer ended!")
            updateButtonLabel()
        }
    }
    
    // MARK: - Private Methods
    
    /// Determines the label for the start/resume/pause button based on the current timer state.
    private var buttonLabel: String {
        return viewModel.isRunning ? "Pause" : "Start/Resume"
    }
    
    /// Updates the button label and sets the timer state to not running.
    private func updateButtonLabel() {
        DispatchQueue.main.async {
            viewModel.isRunning = false
        }
    }
}
