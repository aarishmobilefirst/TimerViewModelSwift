//
//  TimerCircleView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI

struct TimerCircleView: View {
    // MARK: - Properties
    
    /// The view model responsible for managing timer logic.
    @ObservedObject var viewModel: TimerViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background circle with a light stroke.
            CircleView(to: 0, from: 1, strokeColor: Color(.label), opacity: 0.09)
            
            // Foreground circle representing timer progress.
            CircleView(to: 0.0, from: viewModel.progress, strokeColor: Color.red.opacity(1), opacity: 1)
                .rotationEffect(.init(degrees: -90))
            
            // Display formatted time inside the circle.
            Text(Helper.formattedTime(for: viewModel.timeRemaining))
                .fontWeight(.semibold)
                .foregroundStyle(Color(.label))
                .font(.largeTitle)
                .padding()
        }
    }
}
