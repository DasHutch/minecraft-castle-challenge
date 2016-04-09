//
//  BaseTableViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/24/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class BaseTableViewController: ContentSizeChangeObservingTableViewController {}

// MARK: - UITableViewDelegate
extension BaseTableViewController {
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        fixCellSeparatorInsets(cell)
    }
    
//MARK: Helpers
    /**
     Fixes UITableViewCell Separator Inset
     
     will set `separatorInset` & `layoutMargins` to `UIEdgeInsetsZero` and turn off
     `preservesSuperviewLayoutMargins`
    */
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
