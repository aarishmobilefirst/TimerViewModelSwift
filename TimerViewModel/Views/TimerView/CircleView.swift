//
//  CircleView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

struct CircleView: View {
    let to: CGFloat
    let from: CGFloat
    let strokeColor: Color
    let opacity: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: to, to: from)
            .stroke(strokeColor.opacity(opacity), style: StrokeStyle(lineWidth: 35, lineCap: .round))
            .frame(width: 280, height: 280)
    }
}


