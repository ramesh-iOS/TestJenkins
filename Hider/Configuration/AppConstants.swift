//
//  AppConstants.swift
//  Hider
//
//  Created by user on 31/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class Config {
    
    static let KGOOGLE_CLIENT_ID = "796341623337-ke27e3fsbec5itv2hqd9amasi1o7hmmi.apps.googleusercontent.com"
    
    //Bundle Configurations
    static let K_VERSION =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    static let K_APP_NAME = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
}
