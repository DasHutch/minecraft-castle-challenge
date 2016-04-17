//
//  CastleChallenge.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/13/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

enum ChallengeStages: Int, CustomStringConvertible {
    case WoodenAge = 0
    case StoneAge
    case IronAge
    case GoldAge
    case DiamondAge
    
    var description: String {
        get {
            switch(self) {
            case WoodenAge:
                return "Wooden"
            case StoneAge:
                return "Stone"
            case IronAge:
                return "Iron"
            case GoldAge:
                return "Gold"
            case DiamondAge:
                return "Diamond"
            }
        }
    }
}

struct CastleChallengeKeys {
    static let Stages = "ages"
    static let Requirements = "requirements"
    
    struct RequirementsTypeKeys {
        static let Construction = "construction"
        static let ConstructionAdditional = "construction_additional"
        static let Materials = "materials"
        static let Treasure = "treasure"
    }
    
    struct StageRequriementItemKeys {
        static let Item = "item"
        static let Quantity = "quantity"
        static let Completed = "completed"
    }
}

enum ChallengeStageRequirements: Int, CustomStringConvertible {
    case Construction = 0
    case Materials
    case Treasure
    
    var description: String {
        get {
            switch(self) {
            case Materials:
                return "Materials"
            case Construction:
                return "Construction"
            case Treasure:
                return "Treasure"
            }
        }
    }
}
 