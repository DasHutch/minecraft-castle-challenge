//
//  HowToPlayViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/23/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class HowToPlayViewController: BaseViewController {
    
    @IBOutlet weak var objectiveHeadlineLabel: UILabel!
    @IBOutlet weak var objectiveBodyLabel: UILabel!
    @IBOutlet weak var plotHeadlineLabel: UILabel!
    @IBOutlet weak var plotBodyLabel: UILabel!
    @IBOutlet weak var tipFootnoteLabel: UILabel!

//MARK: - Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        updateUI()
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
