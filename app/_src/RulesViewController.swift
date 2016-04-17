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
    lazy var rules = CastleChallengeDataManager().rules()

// MARK: - Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        reloadTableViewData()
    }
    
    override func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        reloadTableViewData()
    }

// MARK: - Private
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
        let rule = CastleChallengeDataManager().ruleForIndexPath(indexPath)
        cell.viewData = RuleTableViewCell.ViewData(rule: rule, withIndex: indexPath.row)
        return cell
    }
}
