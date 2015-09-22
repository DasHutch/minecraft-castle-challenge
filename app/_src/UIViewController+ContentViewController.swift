//
//  UIViewController+ContentViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/13/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var contentViewController: UIViewController? {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController
        }else {
            return self
        }
    }
}