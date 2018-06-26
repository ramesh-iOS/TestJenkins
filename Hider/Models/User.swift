//
//  User.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

final class User: Codable {
    
    var userId: String?
    var name: String?
    var age:String?
    var password: String?
    
    init() {
        // empty initialization 
    }
    
}

extension User: Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<User, ErrorResult> {
        print(dictionary)
        return Result.failure(ErrorResult.parser(string: "Unable to parse"))
    }
}

