//
//  FileManager.swift
//  first-person
//
//  Created by Gregory Hutchinson on 8/15/15.
//  Copyright © 2015 Maker Things. All rights reserved.
//

import Foundation

/// A FileManager to handle app directories, moving files around
/// and handling any downloaded files (to proper directory, or removing, etc)
class FileManager {
    
    private let fileManager = NSFileManager.defaultManager()
    
    //MARK: - Lifecycle
    static let defaultManager = FileManager()
    private init(){}
    
    //MARK: - Public
    
    //MARK: Application Directories
    
    /**
    Retrieves the `Application Support` Directory.
    
    If directory does not exist, create it first.
    
    **Note:** if unable to create this will exit hard.
    
    - returns: path of `Application Support` directory
    */
    func applicationSupportDirectory() -> String {
        
        let directories = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
        
        guard let applicationSupportDirectory = directories.first else {
            log.warning("Application Support Directory DOES NOT exist, attempting to create it")
            
            do {
                try fileManager.createDirectoryAtPath("", withIntermediateDirectories: true, attributes: nil)
            }catch  {
                log.error("Failed to Create `Application Support` directory: \(error)")
                
                //NOTE: If app gets here and is unable to create the directory we need
                //      only thing left to do is give up the ghost...
                fatalError()
            }
            
            //NOTE: Force unwrap, because we just successfully created the `Application Directory`
            //      if we get here and this fails, we want to crash hard.
            let directories = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
            return directories.first!
        }
        
        return applicationSupportDirectory
    }
    
    /**
    Retrieves the `Documents` Directory.
    
    - returns: path of `Documents` directory
    */
    func documentsDirectory() -> String {
        
        let directories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        guard let documentsDirectory = directories.first else {
            log.warning("Document Directory DOES NOT exist, attempting to create it")
            
            do {
                try fileManager.createDirectoryAtPath("", withIntermediateDirectories: true, attributes: nil)
            }catch  {
                log.error("Failed to Create `Document` directory: \(error)")
                
                //NOTE: If app gets here and is unable to create the directory we need
                //      only thing left to do is give up the ghost...
                fatalError()
            }
            
            //NOTE: Force unwrap, because we just successfully created the `Documents`
            //      if we get here and this fails, we want to crash hard.
            let directories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            return directories.first!
        }
        
        return documentsDirectory
    }

    
    //MARK: Directory & File Existence
    
    /**
    Checks if the File or Directory exists
    
    - parameter fullPath: The Path of the file or directory to check
    - parameter isDirectory: Is the `fullPath` a directory or not
    
    - returns: `true` if file or directory exist otherwise `false`
    */
    private func doesFileExist(fullPath: String, isDirectory: Bool) -> Bool {
        
        var isDir: ObjCBool
        
        //????: Can't convert a Bool to ObjCBool, feels kludgey
        if isDirectory {
            isDir = true
        }else {
            isDir = false
        }
        
        if fileManager.fileExistsAtPath(fullPath, isDirectory:&isDir) {
            if isDir {
                //NOTE: file exists and is a directory
                log.verbose("Directory Exists: \(fullPath)")
                return true
            } else {
                //NOTE: file exists and is not a directory
                log.verbose("File Exists: \(fullPath)")
                return true
            }
        } else {
            //NOTE: file does not exist
            log.verbose("File DOES NOT Exists: \(fullPath)")
            return false
        }
    }
    
    //MARK: Copying & Moving Files / Directories
    func copyFileToApplicationDocumentsDir(filePath: String) {
        
    
        let docsDir = documentsDirectory()
        
        let filename = NSString(string: filePath).lastPathComponent
        let fullFilePath = docsDir.stringByAppendingString("/\(filename)")
        
        if UserDefaults.defaultManager.shouldResetChallenge {
            
            log.verbose("Resetting Challenge Progress..")
            
            do {
                try NSFileManager.defaultManager().removeItemAtPath(fullFilePath)
            }catch let error as NSError {
                log.error(error.localizedDescription)
            }
        }

        do {
            try NSFileManager.defaultManager().copyItemAtPath(filePath, toPath: fullFilePath)
        }catch let error as NSError {
            log.error(error.localizedDescription)
        }
    }
    
    //MARK: Writing to Directories
    func applicationTmpDirectory() -> String {
        
        //????: This will return nil, if not avail
        //      should prob make one?
        return NSTemporaryDirectory()
    }
    
    func saveChallengeProgressPLIST(plist: NSDictionary) {
        
        let success = plist.writeToFile(challengeProgressPLIST(), atomically: true)
        
        if success {
            log.verbose("successfuly, updated challenge progress plist data")
        }else {
            log.error("unable to update challenge progress plist data")
        }
    }
    
    //MARK: - Custom App File(s)
    func challengeProgressPLIST() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docs = paths.first!
        
        let fileName = CastleChallengeFiles.DefaultData.FileName
        let fileExtension = CastleChallengeFiles.DefaultData.FileExtension
        let plist = docs.stringByAppendingString("/\(fileName).\(fileExtension)")
        return plist
    }
    
    //MARK: - Private
}