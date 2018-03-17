//
//  Created by Levi Eggert.
//  Copyright © 2017 Levi Eggert. All rights reserved.
//

import UIKit

public class SeekProperties
{
    public var fromAlpha: CGFloat = 1
    public var toAlpha: CGFloat = 1
    public var fromTransform: CGAffineTransform = CGAffineTransform.identity
    public var toTransform: CGAffineTransform = CGAffineTransform.identity
    public var fromConstraintConstant: CGFloat = 0
    public var toConstraintConstant: CGFloat = 0
    
    public init(fromAlpha: CGFloat = 1, toAlpha: CGFloat = 1, fromTransform: CGAffineTransform = CGAffineTransform.identity, toTransform: CGAffineTransform = CGAffineTransform.identity, fromConstraintConstant: CGFloat = 0, toConstraintConstant: CGFloat = 0)
    {
        self.fromAlpha = fromAlpha
        self.toAlpha = toAlpha
        self.fromTransform = fromTransform
        self.toTransform = toTransform
        self.fromConstraintConstant = fromConstraintConstant
        self.toConstraintConstant = toConstraintConstant
    }
}
