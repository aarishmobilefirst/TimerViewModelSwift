//
//  BubbleEffectViewModel.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

class BubbleEffectViewModel: ObservableObject{
    
    @Published var viewBottom: CGFloat = CGFloat.zero
    @Published var bubbles: [BubbleViewModel] = []
    private var timer: Timer?
    private var timerCount: Int = 0
    @Published var bubbleCount: Int = 50
    
    func addBubbles(frameSize: CGSize){
        let lifetime: TimeInterval = 2
        //Start timer
        timerCount = 0
        if timer != nil{
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            let bubble = BubbleViewModel(height: 10, width: 10, x: frameSize.width/2, y: self.viewBottom, color: .red, lifetime: lifetime)
            //Add to array
            self.bubbles.append(bubble)
            //Get rid if the bubble at the end of its lifetime
            Timer.scheduledTimer(withTimeInterval: bubble.lifetime, repeats: false, block: {_ in
                self.bubbles.removeAll(where: {
                    $0.id == bubble.id
                })
            })
            if self.timerCount >= self.bubbleCount {
                //Stop when the bubbles will get cut off by screen
                timer.invalidate()
                self.timer = nil
            }else{
                self.timerCount += 1
            }
        }
    }
}
