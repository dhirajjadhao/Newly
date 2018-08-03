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
    private let app = UIApplication.shared.delegate
    private var window = UIWindow()
    
    
    //MARK: Properties
    
    private var update = UIButton()
    
    /// Newly Delegate
    public var delegate:NewlyDelegate?
    
    /// Whether Newly is currently visible.
    public var isUpdateVisible = Bool()
    
    /// It defines whether Newly should hide on touch, default is true.
    public var hideOnTouch = Bool()
    
    /// Animation interval to show newly on screen.
    public var showAnimationInterval:TimeInterval?
    
    /// Animation interval to hide newly from screen.
    public var hideAnimationInterval:TimeInterval?
    
    /// Height from top at which Newly should be displayed.
    public var heightOffset:CGFloat?
    
    /// Background colour for Newly
    public var backgroundColor:UIColor?
    
    /// Text colour for Newly
    public var textColor:UIColor?
    
    /// Text Font for Newly
    public var textFont:UIFont!
    
    /// Height of Newly
    public var height:CGFloat!

    /// Y live position of Newly
    public var yPosition: CGFloat {
      get {
        return update.frame.origin.y
      }
      set {
        update.frame.origin.y = newValue
      }
    }
  
    /// Current text of Newly
    public var text: String? {
      get {
        return update.titleLabel?.text
      }
      set {
        update.setTitle(newValue, for: .normal)
      }
    }
    
    /// Border Width of Newly
    public var borderWidth:CGFloat!
    
    /// Border Colour for Newly
    public var borderColor:UIColor?
    
    /// Initializers
    
    public override init() {
        super.init()
        
        isUpdatedAddedInWindow = false
        textFont = UIFont.systemFont(ofSize: 12.5)
        height = 30
        isUpdateVisible = false
        hideOnTouch = true
        showAnimationInterval = 1.0
        hideAnimationInterval = 1.0
        heightOffset = 78.0
        backgroundColor = UIColor(red: 0, green: 153.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        textColor = UIColor.white
        borderWidth = 0.0
        borderColor = UIColor.darkGray
    }
    
    
    
    //MARK: Showing and Hiding Newly
    
    
    ///Shows Newly updates available button with animation
    ///
    /// - parameter message: text message to be shown in Newly update
    /// - parameter view: view to display newly on (optional)
    public func showUpdate(message:String, onView view: UIView? = nil) -> Void {
        
        window = ((app?.window)!)!
        
        if !isUpdatedAddedInWindow! {
            
            let viewWidth = view?.frame.width ?? window.frame.width
            
            var width = message.widthOfString(usingFont: textFont)
            if width >= viewWidth {
                width = viewWidth - 10.0
            }
            update = UIButton(frame: CGRect(x: 0, y: -50, width: width, height: height))
            update.setTitle(message, for: UIControlState.normal)
            update.center.x = viewWidth/2.0
            update.backgroundColor = backgroundColor
            update.layer.cornerRadius = height/2.0
            update.layer.masksToBounds = true
            update.titleLabel?.textAlignment = NSTextAlignment.center
            update.setTitleColor(textColor, for: UIControlState.normal)
            update.titleLabel?.font = textFont
            update.layer.borderWidth = borderWidth
            update.layer.borderColor = borderColor?.cgColor
            update.addTarget(self, action: #selector(updateButtonTapped), for: UIControlEvents.touchDown)
            update.addTarget(self, action: #selector(updateButtonTouchUpInside), for: UIControlEvents.touchUpInside)
            update.addTarget(self, action: #selector(updateButtonTouchUpInside), for: UIControlEvents.touchDragExit)
            (view ?? window).addSubview(update)
            isUpdatedAddedInWindow = true
            
        }
        
        if !isUpdateVisible {
            
            isUpdateVisible = true
            
            UIView.animate(withDuration: showAnimationInterval!, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.update.frame.origin.y = self.heightOffset!
                
                }, completion: nil)
        }
        
        
        
    }
    
    
    
    /// Hides Newly with animation
    
    public func hideUpdate() -> Void {
        
        isUpdateVisible = false
        isUpdatedAddedInWindow = false
        
        UIView.animate(withDuration: hideAnimationInterval!, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
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
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width+30
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
