import Foundation
import UserNotifications
class MNotification{

    @available(iOS 10.0, *)
    static func scheduleLocalNotification(title:String, subtitle:String, body: String) {

        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        notificationContent.sound = UNNotificationSound.default()

        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
         //   if let error = error {
//                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
       //     }
        }
    }
}
