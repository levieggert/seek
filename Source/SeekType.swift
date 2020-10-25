//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

public protocol SeekType {
    
    associatedtype ValueType
    
    var fromValue: ValueType { get }
    var toValue: ValueType { get }
        
    func valueForPosition(position: CGFloat) -> ValueType
}
