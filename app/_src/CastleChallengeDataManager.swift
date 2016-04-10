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

    func dataForAge(age: String) throws -> NSMutableDictionary {
        let path = FileManager.defaultManager.challengeProgressPLIST()
        let plistDict = NSMutableDictionary(contentsOfFile: path)
        guard plistDict != nil else {
            log.severe("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
            throw NSError(domain: "com.minecraft.castle.challenge.errors.filesystem", code: 1000, userInfo: [NSLocalizedDescriptionKey: "file is missing"])
        }

        guard let ages = plistDict!["ages"] as? NSMutableDictionary else {
            log.severe("Stage / Data from saved PLIST is missing `ages` dictionary. Possibly, a corrupt plist file?!")
            throw NSError(domain: "com.minecraft.castle.challenge.errors.plist.parsing", code: 1000, userInfo: [NSLocalizedDescriptionKey: "missing key in plist"])
        }

        let ageLowerCase = age.lowercaseString
        guard let age = ages[ageLowerCase] as? NSMutableDictionary else {
            throw NSError(domain: "com.minecraft.castle.challenge.errors.plist.parsing", code: 1000, userInfo: [NSLocalizedDescriptionKey: "missing key in plist"])
        }

        log.verbose("Config'd Data for Age: \(age) from PLIST")
        return age
    }

    func dataForRules() throws -> NSArray {
        let path = FileManager.defaultManager.challengeProgressPLIST()
        let plistDict = NSMutableDictionary(contentsOfFile: path)
        guard plistDict != nil else {
            log.severe("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
            throw NSError(domain: "com.minecraft.castle.challenge.errors.filesystem", code: 1000, userInfo: [NSLocalizedDescriptionKey: "file is missing"])
        }

        guard let rules = plistDict!["rules"] as? NSArray else {
            log.severe("Stage / Data from saved PLIST is missing `rules` dictionary. Possibly, a corrupt plist file?!")
            throw NSError(domain: "com.minecraft.castle.challenge.errors.plist.parsing", code: 1000, userInfo: [NSLocalizedDescriptionKey: "missing key in plist"])
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
