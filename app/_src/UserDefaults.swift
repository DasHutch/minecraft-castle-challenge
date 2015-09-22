//
//  UserDefaults.swift
//  whatareyouintoo
//
//  Created by Gregory Hutchinson on 8/14/15.
//  Copyright © 2015 Maker Things. All rights reserved.
//

import UIKit

/**
UserDefaults Keys

- parameter isFirstLaunch: Is this the first time app has been launched
*/
struct DefaultsKeys {
    static let isFirstLaunch  = "is_first_launch"
    static let shouldResetChallengeProgress = "should_reset_challenege_progress"
}

/**
UserDefaults InitialValues

- parameter isFirstLaunch: Initial value of `true`
*/
struct DefaultsInitialValues {
    static let isFirstLaunch = true
    static let shouldResetChallengeProgress = false
}

/// A manager for all 'app' & 'user' defaults
class UserDefaults {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var isFirstLaunch: Bool {
        get {
            //NOTE: Assume it is first launch if this value is not set anywhere
            //      before being accessed
            return defaults.objectForKey(DefaultsKeys.isFirstLaunch) as? Bool ?? DefaultsInitialValues.isFirstLaunch
        }
        set {
            defaults.setBool(newValue, forKey: DefaultsKeys.isFirstLaunch)
            sync()
        }
    }
    
    var shouldResetChallenge: Bool {
        get {
            //NOTE: Assume it is first launch if this value is not set anywhere
            //      before being accessed
            return defaults.objectForKey(DefaultsKeys.shouldResetChallengeProgress) as? Bool ?? DefaultsInitialValues.shouldResetChallengeProgress
        }
        set {
            defaults.setBool(newValue, forKey: DefaultsKeys.shouldResetChallengeProgress)
            sync()
        }
    }
    
    //MARK: - Lifecycle
    static let defaultManager = UserDefaults()
    private init() {}
    
    //MARK: - Public
    
    /**
    Setups & registers default values
    */
    func setup() {
        registerDefaults()
    }
    
    /**
    Manually saves any pending `values` for **UserDefaults**.
    
    Should not have to call this as `newValues` are saved on setting.
    However, this is here just just in case
    */
    func saveDefaults() {
        sync()
    }
    
    //MARK: - Private
    private func registerDefaults() {
        //NOTE: register all default values
        
        let firstLaunchDefault = [DefaultsKeys.isFirstLaunch : DefaultsInitialValues.isFirstLaunch]
        defaults.registerDefaults(firstLaunchDefault)
        
        let shouldResetChallengeDefault = [DefaultsKeys.shouldResetChallengeProgress : DefaultsInitialValues.shouldResetChallengeProgress]
        defaults.registerDefaults(shouldResetChallengeDefault)
    }
    
    /**
    Synchronizes `NSUserDefaults`
    */
    private func sync() {
        let didSync = defaults.synchronize()
        
        if didSync {
            log.verbose("Defaults successfully saved")
        }else {
            log.warning("Defaults were unable to be saved")
        }
    }
}
