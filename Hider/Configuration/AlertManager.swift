//
//  AlertManager.swift
//  Hider
//
//  Created by user on 14/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

enum Prompt {
    
    case networkUnavailable
    case serverNotResponding
    case custom(String)
        
    var message: String? {
        
        switch self {
        case .networkUnavailable:
            return ""
        case .serverNotResponding:
            return ""
        case .custom(let message):
            return message
        }
    }
}

class AlertManager {
    
    typealias actionHandler = ()->()
    
    static func showAlert(type: Prompt, action: actionHandler? = nil, actionTitle: String? = nil) {
        
        let alert = UIAlertController.init(title: nil, message: type.message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle ?? "OK", style: UIAlertActionStyle.default, handler: { Void in
            guard let _ = action else { return }
            action!()
        })
        alert.addAction(action)
        
        if actionTitle != nil {
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        var controller = UIApplication.shared.keyWindow?.rootViewController
        while ((controller?.presentedViewController) != nil) {
            controller = controller?.presentedViewController
        }
        
        if (controller?.isKind(of: UIAlertController.self))! {
            return
        }
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
