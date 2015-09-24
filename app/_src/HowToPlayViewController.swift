//
//  HowToPlayViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/23/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {
    
    @IBOutlet weak var objectiveHeadlineLabel: UILabel!
    @IBOutlet weak var objectiveBodyLabel: UILabel!
    @IBOutlet weak var plotHeadlineLabel: UILabel!
    @IBOutlet weak var plotBodyLabel: UILabel!
    @IBOutlet weak var tipFootnoteLabel: UILabel!
    
    var csdcObserver: NSObjectProtocol?

    //MARK: - Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            self.updateUI()
        }
        
        updateUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if csdcObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(csdcObserver!)
        }
    }
    
    //MARK: - Private 
    private func updateUI() {
        
        objectiveHeadlineLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleHeadline)
        objectiveBodyLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleBody)

        plotHeadlineLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleHeadline)
        plotBodyLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleBody)
        
        tipFootnoteLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleFootnote)
    }
}
