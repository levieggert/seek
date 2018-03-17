//
//  Created by Levi Eggert.
//  Copyright © 2017 Levi Eggert. All rights reserved.
//

import UIKit

extension Seek
{
    // MARK: - ImageView Animations
    
    public static func animateImageView(imageView: UIImageView, image: UIImage?, duration: TimeInterval, toAlpha: CGFloat = 1, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let imageViewHasImage: Bool = imageView.image != nil
        let newImage: Bool = image != nil
        
        if (!imageViewHasImage && newImage)
        {
            imageView.image = image
            _ = Seek.view(view: imageView, duration: duration, properties: SeekProperties(fromAlpha: 0, toAlpha: toAlpha), complete: complete)
        }
        else if (imageViewHasImage && newImage)
        {
            Seek.transitionImageView(imageView: imageView, image: image, duration: duration, complete: complete)
        }
        else if (imageViewHasImage && !newImage)
        {
            _ = Seek.view(view: imageView, duration: duration, properties: SeekProperties(fromAlpha: 1, toAlpha: 0), complete: { (finished: Bool) in
                
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
    
    // MARK: - Button Animations
    
    public static func animateButtonImage(button: UIButton, image: UIImage?, duration: TimeInterval, complete:((_ finished: Bool) -> Void)? = nil)
    {
        let buttonHasImage: Bool = button.imageView?.image != nil
        let newButtonImage: Bool = image != nil
        
        if (!buttonHasImage && newButtonImage)
        {
            button.setImage(image, for: .normal)
            _ = Seek.view(view: button, duration: duration, properties: SeekProperties(fromAlpha: 0, toAlpha: 1), complete: complete)
        }
        else if (buttonHasImage && newButtonImage)
        {
            Seek.transitionButton(button: button, image: image, duration: duration, complete: complete)
        }
        else if (buttonHasImage && !newButtonImage)
        {
            _ = Seek.view(view: button, duration: duration, properties: SeekProperties(fromAlpha: 1, toAlpha: 0), complete: { (finished: Bool) in
                
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
    
    // MARK: - Label Animations
    
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
}
