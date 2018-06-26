//
//  NotificationManager.swift
//  Hider
//
//  Created by user on 31/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    
    class func registerPush() {
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}
