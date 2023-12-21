//
//  BubbleEffectView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

struct BubbleEffectView: View {
    
    @StateObject var viewModel: BubbleEffectViewModel = BubbleEffectViewModel()
    var replay: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                //Show bubble views for each bubble
                ForEach(viewModel.bubbles){bubble in
                    BubbleView(bubble: bubble)
                }
            }.onChange(of: replay, perform: { _ in
                viewModel.addBubbles(frameSize: geo.size)
            })
            
            .onAppear(){
                //Set the initial position from frame size
                viewModel.viewBottom = geo.size.height
                viewModel.addBubbles(frameSize: geo.size)
            }
        }
    }
}
