//
//  ActivityIndicatorView.swift
//  Hider
//
//  Created by user on 08/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

enum Loader {
    case simple
    case text
}

final class ActivityIndicatorView: UIView {

    class func instanceFromNib() -> ActivityIndicatorView {
        return UINib(nibName: "ActivityIndicator", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ActivityIndicatorView
    }
    
    @IBOutlet private var indicator: UIActivityIndicatorView! = nil
    @IBOutlet private var visualEffectView: UIVisualEffectView! = nil {
        didSet {
            visualEffectView.alpha = 0.8
            visualEffectView.layer.cornerRadius = 0.15*visualEffectView.bounds.width
            visualEffectView.layer.masksToBounds = true
        }
    }
    @IBOutlet private var label: UILabel! = nil
    @IBOutlet var verticalConstraint: NSLayoutConstraint! 
    
    var isLoaderAnimating: Bool! {
        get {
            return indicator.isAnimating
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setType(_ loader: Loader) {
        switch loader {
        case .simple:
            self.setSimpleLoader()
        case .text:
            self.setLoaderWithText()
        }
    }
    
    private func setSimpleLoader() {
        visualEffectView.isHidden = true
        label.isHidden = true
        indicator.color = .white
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        indicator.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
    }
    
    private func setLoaderWithText() {
        // default properties
    }
    
    public func startIndicator() {
        self.indicator.startAnimating()
    }
    
    public func stopIndicator() {
        self.indicator.startAnimating()
    }
    
    public func setText(_ text:String) {
        self.label.text = text
    }
    
    public func setVerticalConstraint(_ offset: CGFloat) {
        self.verticalConstraint.constant = offset
    }
    
    public func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    public func setIndicatorViewColor(_ color: UIColor) {
        self.visualEffectView.backgroundColor = color
        self.visualEffectView.alpha = 0.2
    }
    
    public func setIndicatorColor(_ color: UIColor) {
        self.indicator.color = color
    }
    
    public func setIndicatorTransform(_ transform: CGAffineTransform) {
        self.indicator.transform = transform
    }
}
