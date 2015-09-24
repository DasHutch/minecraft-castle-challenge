//
//  BaseTableViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/24/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

}

// MARK: - UITableViewDelegate
extension BaseTableViewController {
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
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
