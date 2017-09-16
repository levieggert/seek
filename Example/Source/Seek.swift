//
//  Created by Levi Eggert.
//  Copyright © 2015 Levi Eggert. All rights reserved.
//

import UIKit

public class Seek
{
    public struct Params
    {
        public var delay: TimeInterval = 0
        public var ease: UIViewAnimationOptions = .curveEaseOut
        public var fromAlpha: CGFloat = 1
        public var toAlpha: CGFloat = 1
        public var fromTransform: CGAffineTransform = CGAffineTransform.identity
        public var toTransform: CGAffineTransform = CGAffineTransform.identity
        public var fromConstraintConstant: CGFloat = 0
        public var toConstraintConstant: CGFloat = 0
        
        public init(fromAlpha: CGFloat = 1, toAlpha: CGFloat = 1, fromTransform: CGAffineTransform = CGAffineTransform.identity, toTransform: CGAffineTransform = CGAffineTransform.identity, fromConstraintConstant: CGFloat = 0, toConstraintConstant: CGFloat = 0, delay: TimeInterval = 0, ease: UIViewAnimationOptions = .curveEaseOut)
        {
            self.fromAlpha = fromAlpha
            self.toAlpha = toAlpha
            self.fromTransform = fromTransform
            self.toTransform = toTransform
            self.fromConstraintConstant = fromConstraintConstant
            self.toConstraintConstant = toConstraintConstant
            self.delay = delay
            self.ease = ease
        }
    }
    
    public weak var view: UIView?
    public weak var constraintLayoutView: UIView?
    public weak var constraint: NSLayoutConstraint?
    
    public var duration: TimeInterval = 1
    public var params: Params = Params()
    
    public required init()
    {
        
    }
    
    // MARK: ImageView Animations
    
    public static func animateImageView(imageView: UIImageView, image: UIImage?, duration: TimeInterval, toAlpha: CGFloat = 1, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let imageViewHasImage: Bool = imageView.image != nil
        let newImage: Bool = image != nil
        
        if (!imageViewHasImage && newImage)
        {
            imageView.image = image
            _ = Seek.view(view: imageView, duration: duration, params: Params(fromAlpha: 0, toAlpha: toAlpha), complete: complete)
        }
        else if (imageViewHasImage && newImage)
        {
            Seek.transitionImageView(imageView: imageView, image: image, duration: duration, complete: complete)
        }
        else if (imageViewHasImage && !newImage)
        {
            _ = Seek.view(view: imageView, duration: duration, params: Params(fromAlpha: 1, toAlpha: 0), complete: { (finished: Bool) in
                
                if (finished)
                {
                    imageView.image = nil
                    imageView.alpha = 1
                }
                
                if let complete = complete
                {
                    complete(finished)
                }
            })
        }
    }
    
    public static func transitionImageView(imageView: UIImageView, image: UIImage?, duration: TimeInterval, transition: UIViewAnimationOptions = .transitionCrossDissolve, complete:((_ finished: Bool) -> Void)? = nil)
    {
        if (duration > 0)
        {
            UIView.transition(with: imageView, duration: duration, options: transition, animations: {
                
                imageView.image = image
                
                }, completion: { (finished: Bool) in
                    
                    if let complete = complete
                    {
                        complete(finished)
                    }
            })
        }
        else
        {
            imageView.image = image
            
            if let complete = complete
            {
                complete(true)
            }
        }
    }
    
    // MARK: Button Animations
    
    public static func animateButtonImage(button: UIButton, image: UIImage?, duration: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let buttonHasImage: Bool = button.imageView?.image != nil
        let newButtonImage: Bool = image != nil
        
        if (!buttonHasImage && newButtonImage)
        {
            button.setImage(image, for: .normal)
            _ = Seek.view(view: button, duration: duration, params: Params(fromAlpha: 0, toAlpha: 1), complete: complete)
        }
        else if (buttonHasImage && newButtonImage)
        {
            Seek.transitionButton(button: button, image: image, duration: duration, complete: complete)
        }
        else if (buttonHasImage && !newButtonImage)
        {
            _ = Seek.view(view: button, duration: duration, params: Params(fromAlpha: 1, toAlpha: 0), complete: { (finished: Bool) in
                
                if (finished)
                {
                    button.setImage(nil, for: .normal)
                    button.alpha = 1
                }
                
                if let complete = complete
                {
                    complete(finished)
                }
            })
        }
    }
    
    public static func transitionButton(button: UIButton, image: UIImage?, duration: TimeInterval, transition: UIViewAnimationOptions = .transitionCrossDissolve, complete:((_ finished: Bool) -> Void)? = nil)
    {
        if (duration > 0)
        {
            UIView.transition(with: button, duration: duration, options: transition, animations: {
                
                button.setImage(image, for: .normal)
                
                }, completion: { (finished: Bool) in
                    
                    if let complete = complete
                    {
                        complete(finished)
                    }
            })
        }
        else
        {
            button.setImage(image, for: .normal)
            
            if let complete = complete
            {
                complete(true)
            }
        }
    }
    
    // MARK: Label Animations
    
    public static func transitionLabel(label: UILabel, text: String?, duration: TimeInterval, transition: UIViewAnimationOptions = .transitionCrossDissolve, complete:((_ finished: Bool) -> Void)? = nil)
    {
        if (duration > 0)
        {
            UIView.transition(with: label, duration: duration, options: transition, animations: {
                
                label.text = text
                
                }, completion: { (finished: Bool) in
                    
                    if let complete = complete
                    {
                        complete(finished)
                    }
            })
        }
        else
        {
            label.text = text
            
            if let complete = complete
            {
                complete(true)
            }
        }
    }
    
    // MARK: Seeking
    
    public static func view(view: UIView, duration: TimeInterval, params: Params, complete:((_ finished: Bool) -> Void)? = nil) -> Seek
    {
        let seek: Seek = Seek()
        
        seek.view = view
        seek.duration = duration
        seek.params = params
        seek.position = 0
        
        seek.toPosition(position: 1, complete: complete)
        
        return seek
    }
    
    public static func constraint(constraint: NSLayoutConstraint, constraintLayoutView: UIView?, duration: TimeInterval, params: Params, complete:((_ finished: Bool) -> Void)? = nil) -> Seek
    {
        let seek: Seek = Seek()
        
        seek.constraint = constraint
        seek.constraintLayoutView = constraintLayoutView
        seek.duration = duration
        seek.params = params
        seek.position = 0
        
        seek.toPosition(position: 1, complete: complete)
        
        return seek
    }
    
    public func toPosition(position: CGFloat, complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.toPosition(position: position, duration: self.duration, params: self.params, complete: complete)
    }
    
    public func toPosition(position: CGFloat, animated: Bool, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let duration: TimeInterval = animated ? self.duration : 0
        
        self.toPosition(position: position, duration: duration, params: self.params, complete: complete)
    }
    
    public func toPosition(position: CGFloat, duration: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.toPosition(position: position, duration: duration, params: self.params, complete: complete)
    }
    
    public func toPosition(position: CGFloat, duration: TimeInterval, params: Params, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let delay: TimeInterval = params.delay
        let ease: UIViewAnimationOptions = params.ease
        
        if (duration > 0 || delay > 0)
        {
            UIView.animate(withDuration: duration, delay: delay, options: ease, animations: { () -> Void in
                
                self.position = position
                
                }) { (finished: Bool) -> Void in
                
                    if let complete = complete
                    {
                        complete(finished)
                    }
            }
        }
        else
        {
            self.position = position
            
            if let complete = complete
            {
                complete(true)
            }
        }
    }
    
    public func forceStop()
    {
        if let view = self.view
        {
            view.layer.removeAllAnimations()
        }
        
        self.position = 0
    }
    
    public func forceComplete(complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.position = 1
        
        if let complete = complete
        {
            complete(true)
        }
    }
    
    public var position: CGFloat = 0 {
        
        didSet(oldValue)
        {
            self.position = Seek.clampPosition(position: self.position)
                        
            if let constraint = self.constraint
            {
                constraint.constant = Seek.getValueAtPosition(position: self.position, fromValue: self.params.fromConstraintConstant, toValue: self.params.toConstraintConstant)
            }

            if let view = self.view
            {
                view.transform = Seek.getTransformAtPosition(position: self.position, fromTransform: self.params.fromTransform, toTransform: self.params.toTransform)
                view.alpha = Seek.getValueAtPosition(position: self.position, fromValue: self.params.fromAlpha, toValue: self.params.toAlpha)
            }
            
            if let constraintLayoutView = self.constraintLayoutView
            {
                constraintLayoutView.layoutIfNeeded()
            }
        }
    }
}
