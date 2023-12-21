//
//  TimerViewModel.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import SwiftUI
import UserNotifications
import Combine

// Protocol for dependencies
protocol TimerViewModelDependencies {
    var notificationCenter: NotificationCenter { get }
    var userNotificationCenter: UNUserNotificationCenter { get }
}

// Default implementation of dependencies
class DefaultTimerViewModelDependencies: TimerViewModelDependencies {
    var notificationCenter: NotificationCenter {
        return NotificationCenter.default
    }
    
    var userNotificationCenter: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }
}

class TimerViewModel: ObservableObject {
    // MARK: - Dependencies
    
    private let dependencies: TimerViewModelDependencies
    
    // MARK: - Published properties
    
    @Published var timeRemaining: TimeInterval = 60.0
    @Published var isRunning: Bool = false
    @Published var progress: CGFloat = 0.0
    @Published var timerEnded = PassthroughSubject<Void, Never>()
    
    // MARK: - Private properties
    
    private var cancellables: Set<AnyCancellable> = []
    private var startDate: Date?
    private var timer: AnyCancellable?
    private var elapsedWhenPaused: TimeInterval = 0.0
    
    // MARK: - Initialization
    
    init(dependencies: TimerViewModelDependencies = DefaultTimerViewModelDependencies()) {
        self.dependencies = dependencies
        
        $isRunning
            .sink { [weak self] isRunning in
                if isRunning {
                    self?.startTimer()
                } else {
                    self?.pauseTimer()
                }
            }.store(in: &cancellables)
        
        dependencies.notificationCenter.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.handleAppDidEnterBackground()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Methods for handling background and timer
    
    func handleAppDidEnterBackground() {
        guard isRunning else { return }
        startNotification(title: "Timer Ended", subTitle: "Your 2-second timer has ended.", body: "Your 2-second timer has ended.", notificationId: "\(UUID())", time: timeRemaining, repeatStatus: false)
    }
    
    func startTimer() {
        if elapsedWhenPaused > 0 {
            startDate = Date().addingTimeInterval(-elapsedWhenPaused)
        } else {
            startDate = Date()
        }
        
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .throttle(for: 0.1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] _ in
                guard let self = self, let startDate = self.startDate else { return }
                
                let elapsed = Date().timeIntervalSince(startDate)
                let remaining = max(0, 60.0 - elapsed)
                
                self.timeRemaining = remaining
                self.progress = CGFloat(elapsed / 60.0)
                
                if remaining <= 0 {
                    self.stopTimer()
                    self.timerEnded.send()
                }
            }
    }
    
    func pauseTimer() {
        timer?.cancel()
        elapsedWhenPaused = Date().timeIntervalSince(startDate ?? Date())
    }
    
    func stopTimer() {
        timer?.cancel()
        timeRemaining = 60.0
        startDate = nil
        elapsedWhenPaused = 0.0
        self.progress = 0.0
    }
    
    func startNotification(title: String, subTitle: String, body: String, notificationId: String, time: TimeInterval, repeatStatus: Bool) {
        NotificationUtility.requestAuthorization { success, error in
            if !success, let error = error {
                print("Notification access not granted.", error.localizedDescription)
                // Handle the error appropriately (e.g., show a user-friendly message)
            } else {
                NotificationUtility.scheduleNotification(
                    title: title,
                    body: body,
                    imageName: "applelogo",
                    time: time,
                    repeatStatus: repeatStatus,
                    notificationId: notificationId
                )
            }
        }
    }
}
