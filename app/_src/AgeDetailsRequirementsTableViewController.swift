//
//  AgeDetailsRequirementsTableViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/31/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

let RequirementCellIdentifier: String = "requirement_cell_identifier"

class AgeDetailsRequirementsTableViewController: BaseTableViewController {
    
    var selectedCells = [NSIndexPath]()
        
    //NOTE: All PLIST Data
    var plistDict: NSMutableDictionary?
    var reqDict: NSMutableDictionary?
    
    var stage: ChallengeStages? {
        didSet {
            configStageData()
        }
    }
    var requirement: ChallengeStageRequirements? {
        didSet {
            configTableViewData()
        }
    }

// MARK: - Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //NOTE: Only get data from plist directly
        //      if it is currently nil here.
        if reqDict == nil {
            configStageData()
        }
        
        configTableView()
    }

    override func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        self.tableView.reloadData()
    }

// MARK: - Private
    private func configStageData() {
        guard let age = stage?.description.lowercaseString else {
            log.warning("Stage is not set, unable to configure stage data")
            return
        }

        do {
            reqDict = try CastleChallengeDataManager().dataForAge(age)
        }catch let error as NSError {
            log.error("Error: \(error)")
        }
    }

    private func configTableView() {
        //????: Seems that setting this from the tableView.rowHeight as exists
        //      in storyboard doesn't actually trigger Autolayout / Self Sizing
        tableView.estimatedRowHeight = 44.0 //tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    private func configTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension AgeDetailsRequirementsTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sections = 0
        if requirement != nil {
            sections = 1
            //TODO: Handle Additional Requirements for Construction
//            switch requirement! {
//            case ChallengeStageRequirements.Construction:
//                sections = 2
//            default: break
//            }
        }
        
        //TODO: Add Section for Additional Construction Reqs
        return sections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = rowsForCurrentRequirementsType()
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RequirementTableViewCell = (tableView.dequeueReusableCellWithIdentifier(RequirementCellIdentifier, forIndexPath: indexPath) as? RequirementTableViewCell)!
        
        //TODO: Refactor to DataManager Class
        let (req, _) = requirementForIndexPath(indexPath)
        if req != nil {
            cell.viewData = RequirementTableViewCell.ViewData(requirement: req!)
        }
        return cell
    }
    
//MARK: Private
    
    //TODO: Refactor to DataManager Class
    private func rowsForCurrentRequirementsType() -> Int {
        var rows = 0
        if requirement != nil {
            guard let data = reqDict else {
                log.error("Stage / Data is nil, possibly not set yet")
                return rows
            }
            
            guard let reqs = data[CastleChallengeKeys.Requirements] as? NSMutableDictionary else {
                log.error("Requirment data is nil, possibly not set yet")
                return rows
            }
    
            switch(requirement!) {
            case ChallengeStageRequirements.Construction:
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
                    rows = constructionReqs.count
                }
                
                //TODO: Handle Additional Construction Requirements?
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.ConstructionAdditional] as? NSMutableArray {
                    rows = constructionReqs.count
                }
                
            case ChallengeStageRequirements.Materials:
                if let materialsReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Materials] as? NSMutableArray {
                    rows = materialsReqs.count
                }
            
            case ChallengeStageRequirements.Treasure:
                if let treasureReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Treasure] as? NSMutableArray {
                    rows = treasureReqs.count
                }
            }
        }
        return rows
    }
    
    private func requirementForIndexPath(indexPath: NSIndexPath) -> (requirement: Requirement?, dictionary: NSMutableDictionary?) {
        var requirementDictionary =  NSMutableDictionary()
        if requirement != nil {
            guard let data = reqDict else {
                log.error("Data is missing")
                return (nil, nil)
            }
            
            guard let reqs = data[CastleChallengeKeys.Requirements] as? NSMutableDictionary else {
                log.error("Requirment data is nil, possibly not set yet")
                return (nil, nil)
            }
            
            switch(requirement!) {
            case ChallengeStageRequirements.Construction:
                //????: Do I need mutable? I dont think so.
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
                    if let req = constructionReqs.atIndex(indexPath.row) as? NSMutableDictionary {
                        requirementDictionary = req
                    }
                }
                
                //TODO: Handle Additional Construction Requirements?
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
                    if let req = constructionReqs.atIndex(indexPath.row) as? NSMutableDictionary {
                        requirementDictionary = req
                    }
                }
                
            case ChallengeStageRequirements.Materials:
                //????: Do I need mutable? I dont think so.
                if let materialsReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Materials] as? NSMutableArray {
                    if let req = materialsReqs.atIndex(indexPath.row) as? NSMutableDictionary {
                        requirementDictionary = req
                    }
                }
                
            case ChallengeStageRequirements.Treasure:
                //????: Do I need mutable? I dont think so.
                if let treasureReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Treasure] as? NSMutableArray {
                    if let req = treasureReqs.atIndex(indexPath.row) as? NSMutableDictionary {
                        requirementDictionary = req
                    }
                }
            }
        }
        
        //TODO: Refactor to DataManager Class
        let quantity = requirementDictionary[CastleChallengeKeys.StageRequriementItemKeys.Quantity] as? NSNumber ?? 0
        let item = requirementDictionary[CastleChallengeKeys.StageRequriementItemKeys.Item] as? String ?? ""
        let completed = requirementDictionary[CastleChallengeKeys.StageRequriementItemKeys.Completed] as? Bool ?? false
        
        return (requirement: Requirement(description: item, quantity: Int(quantity), completed: completed), dictionary: requirementDictionary)
    }

    //TODO: Refactor to DataManager Class
    private func saveRequirementsData() {
        if plistDict != nil {
            FileManager.defaultManager.saveChallengeProgressPLIST(plistDict!)
        }else {
            log.warning("Attempting to save nil data, aborting.")
        }
    }
}

// MARK: - UITableViewDelegate
extension AgeDetailsRequirementsTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if selectedCells.contains(indexPath) {
            //TODO: Refactor to DataManager Class
            if plistDict != nil && reqDict != nil && stage != nil && requirement != nil {
                let (_, dict) = requirementForIndexPath(indexPath)
                if dict != nil {
                    dict![CastleChallengeKeys.StageRequriementItemKeys.Completed] = false
                    saveRequirementsData()
                    if let index = selectedCells.indexOf(indexPath) {
                        selectedCells.removeAtIndex(index)
                    }
                }
            }
        }else {
            //TODO: Refactor to DataManager Class
            if plistDict != nil && reqDict != nil && stage != nil && requirement != nil {
                let (_, dict) = requirementForIndexPath(indexPath)
                if dict != nil {
                    dict![CastleChallengeKeys.StageRequriementItemKeys.Completed] = true
                    saveRequirementsData()
                    selectedCells.append(indexPath)
                }
            }
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
}
