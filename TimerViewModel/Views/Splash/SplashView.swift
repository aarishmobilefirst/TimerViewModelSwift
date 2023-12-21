//
//  SplashView.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 21/12/23.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Properties
    @State private var isActive: Bool = false
    @State private var rotationAngle: Double = 0.0
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Body
    var body: some View {
        ZStack {
            content
        }
        .onAppear {
            setupSplashAnimation()
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .ignoresSafeArea()
    }

    // MARK: - Main Content
    private var content: some View {
        Group {
            if isActive {
                ContentView()
            } else {
                splashContent
            }
        }
    }

    // MARK: - Splash Content
    private var splashContent: some View {
        VStack {
            splashImage
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    animateRotation()
                }
                .padding()

            Text("Timer")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 50)
        }
    }

    // MARK: - Splash Image
    private var splashImage: some View {
        Image(systemName: "timer")
            .symbolRenderingMode(.palette)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
            .foregroundStyle(Color(.label), .red)
    }

    // MARK: - Animation Setup
    private func setupSplashAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.isActive = true
            }
        }
    }

    // MARK: - Rotation Animation
    private func animateRotation() {
        withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
            self.rotationAngle += 360
        }
    }
}

// MARK: - Preview
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
