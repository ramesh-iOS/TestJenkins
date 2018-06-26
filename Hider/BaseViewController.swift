//
//  BaseViewController.swift
//  Chnen
//
//  Created by user on 01/06/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit

protocol LoadingProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class BaseViewController: UIViewController {
    
    lazy private var loaderView: ActivityIndicatorView = {
        let view  = ActivityIndicatorView.instanceFromNib()
        view.frame = self.view.frame
        view.setType(.text)
        view.startIndicator()
        return view
    }()
    
    var isLoading = false
    var isLoaderAnimating : Bool! {
        get {
           return loaderView.isLoaderAnimating
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func addCustomNavigationView(_ view: UIView) {
        
        self.navigationItem.titleView = view
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func showLoader(color: UIColor? = nil) {
        
        if let bgColor = color {
            loaderView.setBackgroundColor(bgColor)
        }
        self.isLoading = true
        self.view.addSubview(self.loaderView)
    }
    
    func hideLoader() {
        self.isLoading = false
        self.loaderView.stopIndicator()
        self.loaderView.removeFromSuperview()
    }
    
    func showLoaderOnWindow() {
        loaderView.setType(.simple)
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.addSubview(loaderView)
    }
}

extension BaseViewController : LoadingProtocol {
    
    func showActivityIndicator() {
        showLoader()
    }
    
    func hideActivityIndicator() {
        hideLoader()
    }
}
