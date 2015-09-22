//
//  RulesViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/20/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

let RuleCellIdentifier: String = "rule_cell_identifier"

class RulesViewController: UITableViewController {
    
    //NOTE: All PLIST Data
    var plistDict: NSMutableDictionary?
    var rules: NSArray?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configRulesData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configTableViewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {}
    
    // MARK: - Private
    private func configRulesData() {
        
        let path = FileManager.defaultManager.challengeProgressPLIST()
        plistDict = NSMutableDictionary(contentsOfFile: path)
        if plistDict != nil {
            
            let rules = plistDict!["rules"] as? NSArray
            if rules != nil {
                
                //NOTE: Using self to be clear in my intention to set local `rules` to class var `rules`
                self.rules = rules
                
                log.verbose("Config'd Data for Rules from PLIST")
            }else {
                log.severe("Stage / Data from saved PLIST is missing `rules` dictionary. Possibly, a corrupt plist file?!")
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

// MARK: - UITableViewDelegate
extension RulesViewController {
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //NOTE: Cell UI updates
        fixCellSeparatorInsets(cell)
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

// MARK: - UITableViewDataSource
extension RulesViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var sections = 0
        if rules != nil {
            sections = 1
        }
        
        return sections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = rules?.count ?? 0
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: RuleTableViewCell = (tableView.dequeueReusableCellWithIdentifier(RuleCellIdentifier, forIndexPath: indexPath) as? RuleTableViewCell)!
        
        let rule = ruleForIndexPath(indexPath)
        cell.loadRule(rule, withIndex: indexPath.row)
        
        return cell
    }
    
    //MARK: Helpers
    private func ruleForIndexPath(indexPath: NSIndexPath) -> String {
        
        var rule = ""
        
        guard let challenegeRules = rules else {
            log.error("Rules Data is missing")
            return rule
        }
        
        //????: Do I have to check for bounds if wrapped with `if let`
        if let theRule = challenegeRules.objectAtIndex(indexPath.row) as? String {
            rule = theRule
        }
    
        return rule
    }
}
