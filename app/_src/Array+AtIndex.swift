//
//  Array+AtIndex.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/24/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import Foundation
import UIKit

/** AtIndex Extends Array
    
    Use of if-let to get a value if within bounds of the array
*/
extension Array {
    /// Allows use of if-let to get a value if within bounds of the array
    func atIndex(index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
}

extension NSArray {
    
    /// Allows use of if-let to get a value if within bounds of the array
    func atIndex(index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
}
