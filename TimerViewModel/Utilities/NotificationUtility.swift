//
//  NotificationUtility.swift
//  TimerViewModel
//
//  Created by Aarish Khanna on 20/12/23.
//

import Foundation
import UserNotifications

class NotificationUtility {
    /// Request user authorization for notifications.
    static func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            completion(success, error)
        }
    }

    /// Schedule a notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - body: The body text of the notification.
    ///   - badge: The badge number for the notification.
    ///   - sound: The sound for the notification.
    ///   - imageName: The name of the image for the notification attachment.
    ///   - time: The time interval after which the notification should be triggered.
    ///   - repeatStatus: Whether the notification should be repeated.
    ///   - notificationId: The unique identifier for the notification request.
    static func scheduleNotification(
        title: String,
        body: String,
        badge: NSNumber = 1,
        sound: UNNotificationSound = .default,
        imageName: String,
        time: TimeInterval,
        repeatStatus: Bool,
        notificationId: String
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = badge

        content.sound = sound

        if let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
                content.attachments = [attachment]
            } catch {
                print("Error creating notification attachment: \(error)")
            }
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: repeatStatus)
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
