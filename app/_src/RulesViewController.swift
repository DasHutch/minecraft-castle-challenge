//
//  RulesViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/20/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

let RuleCellIdentifier: String = "rule_cell_identifier"

class RulesViewController: BaseTableViewController {
    
    //TODO: Refactor to DataManager Class
    var plistDict: NSMutableDictionary?
    
    lazy var rules = [Rule]()

    var csdcObserver: NSObjectProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configRulesData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            self.reloadTableViewData()
        }
        
        configTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadTableViewData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if csdcObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(csdcObserver!)
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {}
    
    // MARK: - Private
    private func configRulesData() {
        
        //TODO: Refactor to DataManager Class
        let path = FileManager.defaultManager.challengeProgressPLIST()
        plistDict = NSMutableDictionary(contentsOfFile: path)
        if plistDict != nil {
            
            let rules = plistDict!["rules"] as? NSArray
            if rules != nil {
                
                for rule in rules! {
                    if let ruleString = rule as? String {
                        
                        //NOTE: Using self since class and local have same var name
                        //      could change it but i mean its semantic and self doesnt hurt anyone
                        self.rules.append(Rule(description: ruleString))

                    }else {
                        log.warning("Rule is not a string, unable to add it to our Rules array: \(rule)")
                    }
                }
                
                log.verbose("Config'd Data for Rules from PLIST")
            }else {
                log.severe("Stage / Data from saved PLIST is missing `rules` dictionary. Possibly, a corrupt plist file?!")
            }
        }else {
            log.warning("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
        }
    }
    
    private func configTableView() {
        
        //????: Seems that setting this from the tableView.rowHeight as exists
        //      in storyboard doesn't actually trigger Autolayout / Self Sizing
        tableView.estimatedRowHeight = 44.0 //tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    private func reloadTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RulesViewController {}

// MARK: - UITableViewDataSource
extension RulesViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return rules.count > 1 ? 1 : 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: RuleTableViewCell = (tableView.dequeueReusableCellWithIdentifier(RuleCellIdentifier, forIndexPath: indexPath) as? RuleTableViewCell)!
        
        //TODO: Refactor to DataManager Class
        let rule = ruleForIndexPath(indexPath)
        cell.viewData = RuleTableViewCell.ViewData(rule: rule, withIndex: indexPath.row)
        
        return cell
    }
    
    //MARK: Helpers
    
    //????: Perhaps make this optional...
    private func ruleForIndexPath(indexPath: NSIndexPath) -> Rule {

        if let theRule = rules.atIndex(indexPath.row) {
            return theRule
        }else {
            return Rule(description: "")
        }
    }
}
