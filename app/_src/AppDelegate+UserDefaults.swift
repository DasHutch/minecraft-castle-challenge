//
//  AppDelegate+UserDefaults.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 4/9/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import Foundation

/**
 Application UserDefaults Setup and Configuration
*/
extension AppDelegate {
    /**
     Setup and register UserDefaults
    */
    func registerDefaults() {
        UserDefaults.defaultManager.setup()
    }
}
