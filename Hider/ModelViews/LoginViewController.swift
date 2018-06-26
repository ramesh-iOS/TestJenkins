//
//  LoginViewController.swift
//  Hider
//
//  Created by user on 25/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    let loginModelView = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        txtEmail.rx.text.orEmpty.map{ $0 }.bind(to: loginModelView.email).disposed(by: disposeBag)
        txtPassword.rx.text.orEmpty.map{ $0 }.bind(to: loginModelView.password).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        let error = self.loginModelView.loginError()
        guard error == nil else {
            AlertManager.showAlert(type: .custom(error!.rawValue))
            return
        }
        
        self.loginUser()
    }
    
    // login user
    func loginUser() {
        
        RequestService.loginUser(self, queryItems: [:]) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                AlertManager.showAlert(type: .custom(error.message))
                break
            }
        }
    }
    
    // facebook login
    @IBAction func btnFacebook(_ sender: UIButton) {
        
        FacebookLogin.loginUser(self) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                if error.message != "" {
                    AlertManager.showAlert(type: .custom(error.message))
                }
                break
            }
        }
    }
    
    @IBAction func btnGoogle(_ sender: UIButton) {
        
        GoogleLogin.loginUser(self) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                if error.message != "" {
                   AlertManager.showAlert(type: .custom(error.message))
                }
                break
            }
        }
    }
    
    @IBAction func btnTwitter(_ sender: UIButton) {
        
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let controller = RegisterViewController.initiatefromStoryboard(.login)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
