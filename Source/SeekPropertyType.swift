//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation

public enum SeekPropertyType {
    
    case alpha(seekFloat: SeekFloat)
    case constraints(seekFloat: SeekFloat)
    case transform(seekTransform: SeekTransform)
}
