//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

public class SeekPosition {
    
    private var position: CGFloat = 0
    
    required init() {
        
    }
    
    public var value: CGFloat {
        
        get {
            return position
        }
        set(newValue) {
            
            if newValue < 0 {
                position = 0
            }
            else if newValue > 1 {
                position = 1
            }
            else {
                position = newValue
            }
        }
    }
}
