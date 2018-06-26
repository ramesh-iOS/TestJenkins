//
//  GoogleLogin.swift
//  Hider
//
//  Created by user on 26/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleLogin: NSObject {
    
    static var instance = GoogleLogin()
    var presentedController: BaseViewController?
    
    typealias loginCompletion = (Result<GIDGoogleUser,ErrorResult>)->Void
    var completion: loginCompletion?
    
    override init() {
        super.init()
    }
    
    func assignDelegates() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    static func loginUser(_ screen: LoadingProtocol,completion: @escaping loginCompletion) {
        
        instance.presentedController = screen as? BaseViewController
        instance.completion = completion
        instance.assignDelegates()
    }
    
    func stopLoading() {
        GoogleLogin.instance.presentedController?.hideLoader()
    }
    
    func showLoading() {
        GoogleLogin.instance.presentedController?.showLoader()
    }
    
    func presentController(_ viewController: UIViewController) {
         GoogleLogin.instance.presentedController?.present(viewController,
                                                           animated: true,
                                                           completion: nil)
    }
}

extension GoogleLogin: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard GoogleLogin.instance.completion != nil else { return }
        self.stopLoading()
        
        /*let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        print("user_id:\(userId ?? "")\ntoken:\(idToken ?? "")\nname:\(fullName ?? "")\ngiven_name:\(givenName ?? "")\nfamily_name\(familyName ?? "")\nemail:\(email ?? "")")*/
        
        if (error) != nil {
            GoogleLogin.instance.completion!(Result.failure(ErrorResult.cancel))
        } else {
            GoogleLogin.instance.completion!(Result.success(user))
        }
    }
}

extension GoogleLogin: GIDSignInUIDelegate {
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        self.showLoading()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
       self.presentController(viewController)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.stopLoading()
        viewController.dismiss(animated: true, completion: nil)
    }
}
