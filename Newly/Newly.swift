//
//  Newly.swift
//  Newly
//
//  Created by Dhiraj Jadhao on 17/11/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit

/// The following protocols are available globally.
public protocol NewlyDelegate {
    
    /// Called when Newly is tapped.
    func newlyDidTapped() -> Void
}


/// Newly is a drop in solution to add Twitter/Facebook/Linkedin style, new updates/tweets/posts available button. It can be used to notify user about new content availability and can other actions can be triggers using its delegate method.

public class Newly: NSObject {
    
    //MARK: Internal Constants
    private var isUpdatedAddedInWindow:Bool?
    private var defaultFont:UIFont!
    private let app = UIApplication.shared.delegate
    private var window = UIWindow()
    private var defaultUpdateHeight:CGFloat!
    
    //MARK: Properties
    
    private var update = UIButton()
    
    /// Newly Delegate
    public var delegate:NewlyDelegate?
    
    /// Whether Newly is currently visible.
    public var isUpdateVisible = Bool()
    
    /// It defines whether Newly should hide on touch, default is true.
    public var hideOnTouch = Bool()
    
    /// Animation interval to show and hide newly on screen.
    public var animationInterval:TimeInterval?
    
    /// Height from top at which Newly should be displayed.
    public var heightOffset:CGFloat?
    
    /// Background colour for Newly
    public var backgroundColor:UIColor?
    
    /// Text colour for Newly
    public var textColor:UIColor?
    
    
    /// Initializers

    public override init() {
        super.init()
        
        isUpdatedAddedInWindow = false
        defaultFont = UIFont.systemFont(ofSize: 12.5)
        defaultUpdateHeight = 30
        isUpdateVisible = false
        hideOnTouch = true
        animationInterval = 1.0
        heightOffset = 78.0
        backgroundColor = UIColor(colorLiteralRed: 0, green: 153.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        textColor = UIColor.white
    }
    
    
    
    //MARK: Showing and Hiding Newly
    
    
    ///Shows Newly updates available button with animation
    ///
    /// - parameter message: text message to be shown in Newly update
    
    
    public func showUpdate(message:String) -> Void {
        
        window = ((app?.window)!)!
        
        if !isUpdatedAddedInWindow! {
            
            var width = message.widthOfString(usingFont: defaultFont)
            if width >= window.frame.width {
                width = window.frame.width - 10.0
            }
            update = UIButton(frame: CGRect(x: 0, y: -50, width: width, height: defaultUpdateHeight))
            update.setTitle(message, for: UIControlState.normal)
            update.center.x = window.frame.width/2.0
            update.backgroundColor = backgroundColor
            update.layer.cornerRadius = defaultUpdateHeight/2.0
            update.layer.masksToBounds = true
            update.titleLabel?.textAlignment = NSTextAlignment.center
            update.setTitleColor(textColor, for: UIControlState.normal)
            update.titleLabel?.font = defaultFont
            
            update.addTarget(self, action: #selector(updateButtonTapped), for: UIControlEvents.touchDown)
            update.addTarget(self, action: #selector(updateButtonTouchUpInside), for: UIControlEvents.touchUpInside)
            window.addSubview(update)
            isUpdatedAddedInWindow = true
            
        }
        
        if !isUpdateVisible {
            
            isUpdateVisible = true
            
            UIView.animate(withDuration: animationInterval!, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.update.frame.origin.y = self.heightOffset!
                
                }, completion: nil)
        }
        
        
        
    }
    
    
    
    /// Hides Newly with animation
    
    public func hideUpdate() -> Void {
        
        isUpdateVisible = false
        isUpdatedAddedInWindow = false
        
        UIView.animate(withDuration: animationInterval!, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.update.frame.origin.y = -50
            
            }, completion: nil)
    }
    
    
    //MARK: Update Button Selectors
    
    @objc private func updateButtonTapped() -> Void {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.update.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            }, completion: { (Bool) in})
        
    }
    
    @objc private func updateButtonTouchUpInside() -> Void {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.update.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }, completion: { (Bool) in})
        if self.hideOnTouch {
            self.hideUpdate()
        }
        
        newlyDidTapped()
    }
    
    
    
    //MARK: Delegates
    
    func newlyDidTapped() -> Void{
        
        delegate?.newlyDidTapped()
    }
    
}


extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width+40
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
