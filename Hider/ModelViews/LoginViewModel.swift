//
//  LoginViewModel.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    enum LoginError: String {
        case empty = "Please fill all the fields."
        case password = "Password must be 8 digits."
        case email = "Please enter valid email address."
    }
    
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    func loginError() -> LoginError? {
        return  (email.value.isEmpty && password.value.isEmpty) ? LoginError.empty :
                (password.value.count < 8) ? LoginError.password :
                email.value.invalidEmail() ? LoginError.email :
                nil
            
    }
}


