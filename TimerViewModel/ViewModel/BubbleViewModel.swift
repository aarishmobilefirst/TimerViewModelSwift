//
//  BubbleViewModel.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

class BubbleViewModel: Identifiable, ObservableObject{
    let id: UUID = UUID()
    @Published var x: CGFloat
    @Published var y: CGFloat
    @Published var color: Color
    @Published var width: CGFloat
    @Published var height: CGFloat
    @Published var lifetime: TimeInterval = 0
    init(height: CGFloat, width: CGFloat, x: CGFloat, y: CGFloat, color: Color, lifetime: TimeInterval){
        self.height = height
        self.width = width
        self.color = color
        self.x = x
        self.y = y
        self.lifetime = lifetime
    }
    func xFinalValue() -> CGFloat {
        return CGFloat.random(in:-width*CGFloat(lifetime*2.5)...width*CGFloat(lifetime*2.5))
    }
    func yFinalValue() -> CGFloat {
        return CGFloat.random(in:0...width*CGFloat(lifetime*2.5))
    }
    
}
