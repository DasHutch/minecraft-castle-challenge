//
//  AgeDetailsRequirementsTableViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/31/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

let RequirementCellIdentifier: String = "requirement_cell_identifier"

class AgeDetailsRequirementsTableViewController: UITableViewController {
    
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
    
    var csdcObserver: NSObjectProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            self.tableView.reloadData()
        }
        
        //NOTE: Only get data from plist directly
        //      if it is currently nil here.
        if reqDict == nil {
            configStageData()
        }
        
        configTableView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if csdcObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(csdcObserver!)
        }
    }

    override func didMoveToParentViewController(parent: UIViewController?) {}

    // MARK: - Private
    private func configStageData() {
        
        let path = FileManager.defaultManager.challengeProgressPLIST()
        plistDict = NSMutableDictionary(contentsOfFile: path)
        if stage != nil && plistDict != nil {
            
            let ageLowerCase = stage!.description.lowercaseString
            let ages = plistDict!["ages"] as? NSMutableDictionary
            if ages != nil {
                
                let age = ages![ageLowerCase]
                reqDict = age as? NSMutableDictionary
                
                log.verbose("Config'd Data for Age from PLIST")
            }else {
              log.severe("Stage / Data from saved PLIST is missing `ages` dictionary. Possibly, a corrupt plist file?!")
            }
        }else {
            log.warning("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
        }
    }
    
    private func configTableView() {
        
        tableView.estimatedRowHeight = 44.0//tableView.rowHeight
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
        
        let req = requirementForIndexPath(indexPath)
        cell.loadRequirement(req)
        
        return cell
    }
    
    //MARK: Private
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
    
            //TODO: Make Keys constants
            switch(requirement!) {
            case ChallengeStageRequirements.Construction:
            
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
                    rows = constructionReqs.count
                }
                
                //TODO: Handle Additional Construction Requirements?
//                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.ConstructionAdditional] as? NSMutableArray {
//                    rows = constructionReqs.count
//                }
                
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
    
    private func requirementForIndexPath(indexPath: NSIndexPath) -> NSDictionary {
        
        var dict = NSDictionary()
        
        if requirement != nil {
            
            guard let data = reqDict else {
                log.error("Data is missing")
                return dict
            }
            
            guard let reqs = data[CastleChallengeKeys.Requirements] as? NSMutableDictionary else {
                log.error("Requirment data is nil, possibly not set yet")
                return dict
            }
            
            switch(requirement!) {
            case ChallengeStageRequirements.Construction:
                
                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
                    
                    //????: Do I have to check for bounds if wrapped with `if let`
                    if let req = constructionReqs.objectAtIndex(indexPath.row) as? NSMutableDictionary {
                        dict = req
                    }
                }
                
                //TODO: Handle Additional Construction Requirements?
//                if let constructionReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Construction] as? NSMutableArray {
//                    
//                    //????: Do I have to check for bounds if wrapped with `if let`
//                    if let req = constructionReqs.objectAtIndex(indexPath.row) as? NSMutableDictionary {
//                        dict = req
//                    }
//                }
                
            case ChallengeStageRequirements.Materials:
                
                if let materialsReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Materials] as? NSMutableArray {
                    
                    //????: Do I have to check for bounds if wrapped with `if let`
                    if let req = materialsReqs.objectAtIndex(indexPath.row) as? NSMutableDictionary {
                        dict = req
                    }
                }
                
            case ChallengeStageRequirements.Treasure:
                
                if let treasureReqs = reqs[CastleChallengeKeys.RequirementsTypeKeys.Treasure] as? NSMutableArray {
                    
                    //????: Do I have to check for bounds if wrapped with `if let`
                    if let req = treasureReqs.objectAtIndex(indexPath.row) as? NSMutableDictionary {
                        dict = req
                    }
                }
            }
        }
        
        return dict
    }
    
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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //NOTE: Cell UI updates
        fixCellSeparatorInsets(cell)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if selectedCells.contains(indexPath) {
        
            if plistDict != nil && reqDict != nil && stage != nil && requirement != nil {
                if let req = requirementForIndexPath(indexPath) as? NSMutableDictionary {
                    req[CastleChallengeKeys.StageRequriementItemKeys.Completed] = false
                    saveRequirementsData()
                    
                    if let index = selectedCells.indexOf(indexPath) {
                        selectedCells.removeAtIndex(index)
                    }
                }
            }
        }else {
            
            if plistDict != nil && reqDict != nil && stage != nil && requirement != nil {
                if let req = requirementForIndexPath(indexPath) as? NSMutableDictionary {
                    req[CastleChallengeKeys.StageRequriementItemKeys.Completed] = true
                    saveRequirementsData()
                    
                    selectedCells.append(indexPath)
                }
            }
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    //MARK: Helpers
    private func fixCellSeparatorInsets(cell: UITableViewCell) {
        
        let separatorInsetSelector = Selector("separatorInset")
        if cell.respondsToSelector(separatorInsetSelector) {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        let preservesSuperviewLayoutMarginsSelector = Selector("preservesSuperviewLayoutMargins")
        if cell.respondsToSelector(preservesSuperviewLayoutMarginsSelector) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        let layoutMarginsSelector = Selector("layoutMargins")
        if cell.respondsToSelector(layoutMarginsSelector) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
}
