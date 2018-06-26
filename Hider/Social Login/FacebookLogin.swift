//
//  FacebookManager.swift
//  v
//
//  Created by user on 14/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

final class FacebookLogin {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    
    //MARK:- User Login
    class func loginUser<T: LoadingProtocol>(_ screen:T, completion: @escaping (Result<FacebookLogin,ErrorResult>)->Void) {
        
        let loginManager : FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: screen as! UIViewController) { (result, error) in
            DispatchQueue.main.async {
                
                guard error == nil, FBSDKAccessToken.current() != nil else {
                    completion(Result.failure(ErrorResult.cancel))
                    return
                }
                
                if result!.grantedPermissions != nil,
                    result!.grantedPermissions.contains("email")  {
                    screen.showActivityIndicator()
                    FacebookLogin.graphRequest(screen, completion: completion)
                    loginManager.logOut()
                } else {
                    completion(Result.failure(ErrorResult.custom(string: "--permission not granted-- OR --email error!--")))
                }
            }
        }
    }
    
    //MARK:- Graph Request
    private class func graphRequest(_ screen:LoadingProtocol, completion: @escaping (Result<FacebookLogin,ErrorResult>)->Void) {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, gender,picture.type(large), email,age_range,link"]).start(completionHandler: { (connection, result, error) -> Void in
            DispatchQueue.main.async {
                guard error == nil, let json = result as? [String:AnyObject] else {
                    screen.hideActivityIndicator()
                    completion(Result.failure(ErrorResult.custom(string: (error?.localizedDescription)!)))
                    return
                }
                
                ParserHelper.parse(dictionary: json, completion: completion)
                screen.hideActivityIndicator()
            }
        })
    }
}

//MARK:- Model Parsing
extension FacebookLogin: Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<FacebookLogin, ErrorResult> {

        print("Facebook User Detail: \(dictionary)")
        
        let facebookObj = FacebookLogin()
        
        if let picture = dictionary["picture"] as? [String:Any] {
            if let data = picture["data"] as? [String:Any] {
                if let url =  data["url"] as? String {
                    facebookObj.imageUrl = url
                }
            }
        }
        if let first_name = dictionary["first_name"] as? String {
            facebookObj.firstName = first_name
        }
        if let last_name = dictionary["last_name"] as? String {
            facebookObj.lastName = last_name
        }
        if let email = dictionary["email"] as? String {
            facebookObj.email = email
        }
        
        return Result.success(facebookObj)
    }
}
