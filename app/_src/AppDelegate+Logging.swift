//
//  AppDelegate+Logging.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 4/9/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import Foundation

/**
 Create global 'log' instance this allows, more refined logging based on build - set log level (verbose, warn, error, etc)
 */
let log = XCGLogger.defaultInstance()

/**
 Application Logging Setup and Configuration
*/
extension AppDelegate {
    /**
     Setup Logging. (level, file, etc)
    */
    func setupLogging() {
        //TODO: Change Log Level based on Environment (Debug -> Verbose / Release -> Warning)
        log.setup(.Verbose, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLogLevel: nil)
        
        //NOTE: Logs can be sent to a file...
        //log.setup(.Error, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLogLevel: nil)
    }
}
