//
//  AppDelegate+Setup.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 4/9/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import Foundation

/**
 Application Setup and Configuration
*/
extension AppDelegate {
    /**
     Setup Application; configure, register, move files around, etc
     
     this will setup the logging, register user defaults, and copy any default resources to the appropriate directories
    */
    func setup() {
        setupLogging()
        registerDefaults()
        setupApplicationDocuments()
    }

    /**
     Setup Application Documents
     
     - note: moves any resource bundle files to `Documents` directory
    */
    func setupApplicationDocuments() {
        copyDefaultDataToDocumentsDirectory()
    }

    /**
     Copies Default Data from resource bundle to `Documents` directory
    */
    private func copyDefaultDataToDocumentsDirectory(bundle: NSBundle = NSBundle.mainBundle(), defaultDataFileName: String = CastleChallengeFiles.DefaultData.FileName, defaultDatafileExt: String = CastleChallengeFiles.DefaultData.FileExtension) {

        if let path = bundle.pathForResource(defaultDataFileName, ofType: defaultDatafileExt) {
            FileManager.defaultManager.copyFileToApplicationDocumentsDir(path)
        }else {
            log.severe("Unable to copy default data from bundle to application documents directory")
            log.verbose("Bundle: \(bundle)")
            log.verbose("Default Data: \(defaultDataFileName).\(defaultDatafileExt)")
        }
    }
}
