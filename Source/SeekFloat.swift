//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

public struct SeekFloat: SeekType {
    
    public let fromValue: CGFloat
    public let toValue: CGFloat
    
    public func valueForPosition(position: CGFloat) -> CGFloat {
                
        return fromValue + (position * (toValue - fromValue))
    }
}
