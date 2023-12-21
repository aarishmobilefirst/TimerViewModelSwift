//
//  BubbleView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

struct BubbleView: View {
    
    //If you want to change the bubble's variables you need to observe it
    @ObservedObject var bubble: BubbleViewModel
    @State var opacity: Double = 0
    
    var body: some View {
        Circle()
            .foregroundColor(bubble.color)
            .opacity(opacity)
            .frame(width: bubble.width, height: bubble.height)
            .position(x: bubble.x, y: bubble.y)
            .onAppear {
                
                withAnimation(.linear(duration: bubble.lifetime)){
                    //Go up
                    self.bubble.y = -bubble.height
                    //Go sideways
                    self.bubble.x += bubble.xFinalValue()
                    //Change size
                    let width = bubble.yFinalValue()
                    self.bubble.width = width
                    self.bubble.height = width
                }
                //Change the opacity faded to full to faded
                //It is separate because it is half the duration
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.linear(duration: bubble.lifetime/2).repeatForever()) {
                        self.opacity = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(Animation.linear(duration: bubble.lifetime/4).repeatForever()) {
                        //Go sideways
                        //bubble.x += bubble.xFinalValue()
                    }
                }
            }
    }
}
