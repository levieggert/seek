//
//  Created by Levi Eggert.
//  Copyright © 2015 Levi Eggert. All rights reserved.
//

import UIKit

extension Seek
{
    // MARK: - Helpers
    
    public static func clampPosition(position: CGFloat) -> CGFloat
    {
        if (position < 0)
        {
            return 0
        }
        else if (position > 1)
        {
            return 1
        }
        
        return CGFloat(NSString(format: "%.2f", position).floatValue)
    }
    
    public static func getValueAtPosition(position: CGFloat, fromValue: CGFloat, toValue: CGFloat) -> CGFloat
    {
        return fromValue + (position * (toValue - fromValue))
    }
    
    // MARK: - Transforms
    
    public static func addTransform(transformA: CGAffineTransform, toTransformB: CGAffineTransform) -> CGAffineTransform
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        transform.a = toTransformB.a + transformA.a
        transform.b = toTransformB.b + transformA.b
        transform.c = toTransformB.c + transformA.c
        transform.d = toTransformB.d + transformA.d
        transform.tx = toTransformB.tx + transformA.tx
        transform.ty = toTransformB.ty + transformA.ty
        
        return transform
    }
    
    public static func subtractTransform(transformA: CGAffineTransform, fromTransformB: CGAffineTransform) -> CGAffineTransform
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        transform.a = fromTransformB.a - transformA.a
        transform.b = fromTransformB.b - transformA.b
        transform.c = fromTransformB.c - transformA.c
        transform.d = fromTransformB.d - transformA.d
        transform.tx = fromTransformB.tx - transformA.tx
        transform.ty = fromTransformB.ty - transformA.ty
        
        return transform
    }
    
    public static func multiplyTransform(transformA: CGAffineTransform, byScalar: CGFloat) -> CGAffineTransform
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        transform.a = transformA.a * byScalar
        transform.b = transformA.b * byScalar
        transform.c = transformA.c * byScalar
        transform.d = transformA.d * byScalar
        transform.tx = transformA.tx * byScalar
        transform.ty = transformA.ty * byScalar
        
        return transform
    }
    
    public static func getTransform(x: CGFloat, y: CGFloat) -> CGAffineTransform
    {
        return CGAffineTransform(translationX: x, y: y)
    }
    
    public static func getTransform(scaleX: CGFloat, scaleY: CGFloat) -> CGAffineTransform
    {
        return CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    public static func getTransform(rotationDegrees: CGFloat) -> CGAffineTransform
    {
        let rotation: CGFloat = CGFloat(Double.pi) * rotationDegrees / 180
        
        return CGAffineTransform(rotationAngle: rotation)
    }
    
    public static func getTransform(x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat) -> CGAffineTransform
    {
        let translation: CGAffineTransform = Seek.getTransform(x: x, y: y)
        let scale: CGAffineTransform = Seek.getTransform(scaleX: scaleX, scaleY: scaleY)
        
        return scale.concatenating(translation)
    }
    
    public static func getTransform(x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat, rotationDegrees: CGFloat) -> CGAffineTransform
    {
        let translation: CGAffineTransform = Seek.getTransform(x: x, y: y)
        let scale: CGAffineTransform = Seek.getTransform(scaleX: scaleX, scaleY: scaleY)
        let rotation: CGAffineTransform = Seek.getTransform(rotationDegrees: rotationDegrees)
        
        let transform: CGAffineTransform = rotation.concatenating(scale)
        
        return transform.concatenating(translation)
    }
    
    public static func getTransformAtPosition(position: CGFloat, fromTransform: CGAffineTransform, toTransform: CGAffineTransform) -> CGAffineTransform
    {
        var transform: CGAffineTransform = CGAffineTransform.identity
        let transformPosition: CGFloat = Seek.clampPosition(position: position)
        
        if (transformPosition > 0 && transformPosition < 1)
        {
            transform = Seek.subtractTransform(transformA: fromTransform, fromTransformB: toTransform)
            transform = Seek.multiplyTransform(transformA: transform, byScalar: transformPosition)
            transform = Seek.addTransform(transformA: transform, toTransformB: fromTransform)
        }
        else if (transformPosition == 0)
        {
            transform = fromTransform
        }
        else if (transformPosition == 1)
        {
            transform = toTransform
        }
        
        return transform
    }
    
    public static func getTransformValue(transform: CGAffineTransform) -> NSValue?
    {
        return NSValue(cgAffineTransform: transform)
    }
}
