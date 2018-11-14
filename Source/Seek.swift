//
//  Created by Levi Eggert.
//  Copyright © 2015 Levi Eggert. All rights reserved.
//

import UIKit

public class Seek
{
    // MARK: - Properties
    
    public weak var view: UIView?
    public weak var constraintLayoutView: UIView?
    public weak var constraint: NSLayoutConstraint?
    
    public var duration: TimeInterval = 1
    public var delay: TimeInterval = 0
    public var ease: UIView.AnimationOptions = .curveEaseOut
    public var properties: SeekProperties = SeekProperties()
    
    public required init()
    {
        
    }
    
    // MARK: - Seek
    
    public static func view(view: UIView, duration: TimeInterval, properties: SeekProperties, complete:((_ finished: Bool) -> Void)? = nil) -> Seek
    {
        let seek: Seek = Seek()
        
        seek.view = view
        seek.duration = duration
        seek.properties = properties
        seek.position = 0
        
        seek.to(position: 1, complete: complete)
        
        return seek
    }
    
    public static func constraint(constraint: NSLayoutConstraint, constraintLayoutView: UIView?, duration: TimeInterval, properties: SeekProperties, complete:((_ finished: Bool) -> Void)? = nil) -> Seek
    {
        let seek: Seek = Seek()
        
        seek.constraint = constraint
        seek.constraintLayoutView = constraintLayoutView
        seek.duration = duration
        seek.properties = properties
        seek.position = 0
        
        seek.to(position: 1, complete: complete)
        
        return seek
    }
    
    public func to(position: CGFloat, complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.to(position: position, duration: self.duration, delay: self.delay, ease: self.ease, complete: complete)
    }
    
    public func to(position: CGFloat, animated: Bool, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let duration: TimeInterval = animated ? self.duration : 0
        
        self.to(position: position, duration: duration, delay: self.delay, ease: self.ease, complete: complete)
    }
    
    public func to(position: CGFloat, duration: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.to(position: position, duration: duration, delay: self.delay, ease: self.ease, complete: complete)
    }
    
    public func to(position: CGFloat, delay: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {
        self.to(position: position, duration: self.duration, delay: delay, ease: self.ease, complete: complete)
    }
    
    public func to(position: CGFloat, duration: TimeInterval, delay: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {        
        self.to(position: position, duration: duration, delay: delay, ease: self.ease, complete: complete)
    }
    
    public func to(position: CGFloat, duration: TimeInterval, delay: TimeInterval, ease: UIView.AnimationOptions, complete:((_ finished: Bool) -> Void)? = nil)
    {
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
                constraint.constant = Seek.getValueAtPosition(position: self.position, fromValue: self.properties.fromConstraintConstant, toValue: self.properties.toConstraintConstant)
            }

            if let view = self.view
            {
                view.transform = Seek.getTransformAtPosition(position: self.position, fromTransform: self.properties.fromTransform, toTransform: self.properties.toTransform)
                view.alpha = Seek.getValueAtPosition(position: self.position, fromValue: self.properties.fromAlpha, toValue: self.properties.toAlpha)
            }
            
            if let constraintLayoutView = self.constraintLayoutView
            {
                constraintLayoutView.layoutIfNeeded()
            }
        }
    }
}
