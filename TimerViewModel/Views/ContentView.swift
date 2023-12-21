//
//  ContentView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TimerViewModel()

    var body: some View {
        TimerView(viewModel: viewModel)
    }
}
