//
//  Newly.swift
//  Newly
//
//  Created by Dhiraj Jadhao on 17/11/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit

protocol NewlyDelegate {
    
    func didTappedUpdate() -> Void
}

class Newly: NSObject {
    
    //MARK: Internal Constants
    private var isUpdatedAddedInWindow:Bool = false
    private let defaultFont = UIFont.systemFont(ofSize: 12.5)
    private let app = UIApplication.shared.delegate
    private var window = UIWindow()
    
    private let defaultUpdateHeight:CGFloat = 30
    
    //MARK: Declaration
    public var delegate:NewlyDelegate?
    public var update = UIButton()
    static let sharedInstance = Newly()

    public var isUpdateVisible:Bool = false
    public var hideOnTouch:Bool = true
    public var animationInterval:TimeInterval = 1.0
    public var heightOffset:CGFloat = 78.0
    public var backgroundColor = UIColor(colorLiteralRed: 0, green: 153.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    public var textColor = UIColor.white

    
    private override init() {
        super.init()
        
    
    }
    
    
    
    //MARK: Interface

    func showUpdate(inView:UIViewController, message:String) -> Void {
       
        window = ((app?.window)!)!

        if !isUpdatedAddedInWindow {
            
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
            
            UIView.animate(withDuration: animationInterval, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.update.frame.origin.y = self.heightOffset
                
                }, completion: nil)
        }
        
        
        
    }
    
    
    func hideUpdate() -> Void {
        
        isUpdateVisible = false
        isUpdatedAddedInWindow = false
        
        UIView.animate(withDuration: animationInterval, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.update.frame.origin.y = -50
            
            }, completion: nil)
    }
    
    
    //MARK: Update Button Tapped
    
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
        
        didTappedUpdate()
    }
    
    
    
    //MARK: Delegates
    
    func didTappedUpdate() -> Void{
        
        delegate?.didTappedUpdate()
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
