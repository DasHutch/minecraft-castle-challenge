//
//  AppDelegate.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/29/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

//NOTE: Create global 'log' instance
//      this allows, more refined logging
//      based on build - set log level (verbose, warn, error, etc)
let log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupLogging()
        registerDefaults()
        
        setupApplicationDocuments()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
    
    //MARK: Setup
    private func setupApplicationDocuments() {
        
        //NOTE: Move any resource bundle files to `Documents`
        //      directory, etc
        
        let mainBundle = NSBundle.mainBundle()
        if let path = mainBundle.pathForResource(CastleChallengeFiles.DefaultData.FileName, ofType: CastleChallengeFiles.DefaultData.FileExtension) {
            
            FileManager.defaultManager.copyFileToApplicationDocumentsDir(path)
        }
    }
    
    private func setupLogging() {
        
        //TODO: Change Log Level based on Environment (Debug -> Verbose / Release -> Warning)
        log.setup(.Verbose, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLogLevel: nil)
        
        //NOTE: Logs can be sent to a file...
        //log.setup(.Error, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLogLevel: nil)
    }
    
    //MARK: App & User Defaults
    private func registerDefaults() {
        UserDefaults.defaultManager.setup()
    }
}

