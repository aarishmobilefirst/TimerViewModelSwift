//
//  TimerButton.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI

struct TimerButton: View {
    // MARK: - Properties
    
    /// The label displayed on the button.
    var label: String
    
    /// The action to be performed when the button is tapped.
    var action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .padding()
                .frame(width: 100, height: 100)
                .background(Color.white)
                .foregroundStyle(Color.red)
                .clipShape(Circle())
        }
    }
}
