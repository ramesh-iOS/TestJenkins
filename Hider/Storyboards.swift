//
//  Storyboards.swift
//  Hider
//
//  Created by user on 22/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import UIKit

enum Storyboards: String {
    
    case login = "Login"
    case home = "Home"
    case profile = "Menu"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewcontrollerClass: T.Type) -> T {
        let storyBoardId = (viewcontrollerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardId) as! T
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func initiatefromStoryboard(_ storyboard: Storyboards) -> Self {
        return storyboard.viewController(viewcontrollerClass:self)
    }
}

