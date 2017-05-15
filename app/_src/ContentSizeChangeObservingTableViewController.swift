//
//  ContentSizeChangeObservingTableViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 4/9/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import Foundation
import UIKit

class ContentSizeChangeObservingTableViewController: UITableViewController {
    //NOTE: Using force unwrap because we always assign this
    //      in `viewWillAppear:` & `addObserverForName:object:queue:` always returns
    //      an `NSObjectProtocol`
    var csdcObserver: NSObjectProtocol!

//MARK: Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterNotifications()
    }

// MARK: Responding to ContentSizeDidChangeNotifcation
    func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        log.severe("Subclass must implement `contentSizeDidChange:`")
        fatalError()
    }

//MARK: Private
    private func registerNotifications() {
        let notifCenter = NSNotificationCenter.defaultCenter()
        csdcObserver = notifCenter.addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { [weak weakSelf = self] (notification) -> Void in

            if let newContentSizeCategory = notification.userInfo?[UIContentSizeCategoryNewValueKey]
                as? String {
                weakSelf?.contentSizeDidChange(newContentSizeCategory)
            }else {
                log.warning("New UIContentSizeCategoryNewValueKey is missing")
                weakSelf?.contentSizeDidChange(String.empty)
            }
        }
    }

    private func deregisterNotifications() {
        let notifCenter = NSNotificationCenter.defaultCenter()
        notifCenter.removeObserver(csdcObserver)
    }
}
