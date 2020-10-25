//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

public class Seek {
    
    public private(set) weak var view: UIView?
    public private(set) weak var constraintLayoutView: UIView?
    public private(set) weak var constraint: NSLayoutConstraint?
    
    public private(set) var seekProperties: [SeekPropertyType]
    
    public let seekPosition: SeekPosition = SeekPosition()
    
    public init(view: UIView, seekProperties: [SeekPropertyType]) {
        
        self.view = view
        self.seekProperties = seekProperties
    }
    
    public init(view: UIView, constraint: NSLayoutConstraint, constraintLayoutView: UIView, seekProperties: [SeekPropertyType]) {
        
        self.view = view
        self.constraint = constraint
        self.constraintLayoutView = constraintLayoutView
        self.seekProperties = seekProperties
    }
    
    public func setSeekProperties(seekProperties: [SeekPropertyType]) {
        
        self.seekProperties = seekProperties
        
        self.position = seekPosition.value
    }
    
    public func animateTo(position: CGFloat, duration: TimeInterval, delay: TimeInterval, animationOptions: UIView.AnimationOptions, complete:((_ finished: Bool) -> Void)?) {
        
        if duration > 0 || delay > 0 {
            
            UIView.animate(withDuration: duration, delay: delay, options: animationOptions, animations: {
                self.position = position
            }) { (finished: Bool) in
                complete?(finished)
            }
        }
        else {
            
            self.position = position
            complete?(true)
        }
    }
    
    public func forceStop() {
        view?.layer.removeAllAnimations()
        position = 0
    }
    
    public func forceComplete(complete:((_ finished: Bool) -> Void)? = nil) {
        position = 1
        complete?(true)
    }
    
    public var position: CGFloat = 0 {
        
        didSet {
            
            seekPosition.value = position
            
            for property in seekProperties {
                
                switch property {
                    
                case .alpha(let seekFloat):
                    view?.alpha = seekFloat.valueForPosition(position: seekPosition.value)
                    
                case .constraints(let seekFloat):
                    constraint?.constant = seekFloat.valueForPosition(position: seekPosition.value)
                    
                case .transform(let seekTransform):
                    view?.transform = seekTransform.valueForPosition(position: seekPosition.value)
                }
            }
            
            constraintLayoutView?.layoutIfNeeded()
        }
    }
}
