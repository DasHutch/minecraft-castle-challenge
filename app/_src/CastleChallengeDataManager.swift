//
//  CastleChallengeDataManager.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 4/9/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import Foundation

/**
 CastleChallengeDataManager Struct
*/
class CastleChallengeDataManager {
    lazy var _rules = [Rule]()

    struct Errors {
        enum FileSystem {
            case missing(file: String?)

            var domain: String {
                return "com.minecraft.castle.challenge.errors.filesystem"
            }

            var code: Int {
                switch self {
                case missing(_):
                    return 1000
                }
            }

            var detail: String {
                switch self {
                case missing(let file):
                    return "file is missing: \(file)"
                }
            }

            var error: NSError {
                return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: detail])
            }
        }

        enum Parsing {
            case missingKey(key: String?)

            var domain: String {
                return "com.minecraft.castle.challenge.errors.parsing"
            }

            var code: Int {
                switch self {
                case missingKey(_):
                    return 1000
                }
            }

            var detail: String {
                switch self {
                case missingKey(let key):
                    return "missing key in dict: \(key)"
                }
            }

            var error: NSError {
                return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: detail])
            }
        }
    }

    func dataForAge(age: String) throws -> NSMutableDictionary {

        let path = FileManager.defaultManager.challengeProgressPLIST()
        let plistDict = NSMutableDictionary(contentsOfFile: path)
        guard plistDict != nil else {
            log.severe("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
            throw Errors.FileSystem.missing(file: path).error
        }

        guard let ages = plistDict!["ages"] as? NSMutableDictionary else {
            log.severe("Stage / Data from saved PLIST is missing `ages` dictionary. Possibly, a corrupt plist file?!")
            throw Errors.Parsing.missingKey(key: "ages").error
        }

        let ageLowerCase = age.lowercaseString
        guard let age = ages[ageLowerCase] as? NSMutableDictionary else {
            throw Errors.Parsing.missingKey(key: ageLowerCase).error
        }

        log.verbose("Config'd Data for Age: \(age) from PLIST")
        return age
    }

    func dataForRules() throws -> NSArray {
        let path = FileManager.defaultManager.challengeProgressPLIST()
        let plistDict = NSMutableDictionary(contentsOfFile: path)
        guard plistDict != nil else {
            log.severe("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
            throw Errors.FileSystem.missing(file: path).error
        }

        guard let rules = plistDict!["rules"] as? NSArray else {
            log.severe("Stage / Data from saved PLIST is missing `rules` dictionary. Possibly, a corrupt plist file?!")
            throw Errors.Parsing.missingKey(key: "rules").error
        }

        return rules
    }

    func rules() -> [Rule] {
        if _rules.count >= 0 {
            return _rules
        }
        
        do {
            let rulesData = try dataForRules()
            var rules = [Rule]()
            for rule in rulesData {
                if let ruleString = rule as? String {
                    rules.append(Rule(description: ruleString))
                }else {
                    log.warning("Rule is not a string, unable to add it to our Rules array: \(rule)")
                }
            }
            return rules
        }catch let error as NSError {
            log.error("Error: \(error)")
            return [Rule]()
        }
    }

    func ruleForIndexPath(indexPath: NSIndexPath) -> Rule {
        if let theRule = rules().atIndex(indexPath.row) {
            return theRule
        }else {
            return Rule(description: "")
        }
    }
}
