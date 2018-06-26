//
//  StringExtension.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

extension String {
    
    func isEmpty() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    func invalidEmail() -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return !(emailPredicate.evaluate(with: self))
    }
}
