//
//  RuleTableViewCell.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/20/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class RuleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    struct ViewData {
        let rule: Rule
        let index: Int
    }
    
    var viewData: ViewData? {
        didSet{
            updateRuleLabel(viewData?.rule.description)
            updateRuleIndexLabel(viewData?.index)
            
            updateLabelFontForDynamicTextStyles()
        }
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        
        //NOTE: Clear Label, Etc
        updateRuleLabel(nil)
        updateRuleIndexLabel(nil)
        
        updateLabelFontForDynamicTextStyles()
    }
    
    //MARK: - Public

    //MARK: - Private
    private func updateRuleLabel(rule: String?) {
        updateLabel(ruleLabel, withText: rule)
    }
    
    private func updateRuleIndexLabel(ruleIndex: Int?) {
        
        if ruleIndex >= 0 && ruleIndex != nil {
            let nonZeroBasedIndex = ruleIndex! + 1
            let ruleIndexString = "\(nonZeroBasedIndex)."
            updateLabel(indexLabel, withText: ruleIndexString)
        }else {
            updateLabel(indexLabel, withText: "")
        }
    }
    
    private func updateLabel(label: UILabel?, withText text: String?) {
        label?.text = text
    }
    
    private func updateLabelFontForDynamicTextStyles() {
        ruleLabel.font =  UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleHeadline)
        indexLabel.font =  UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleBody)
    }
}

extension RuleTableViewCell.ViewData {
    init(rule: Rule, withIndex index: Int) {
        self.rule = rule
        self.index = index
    }
}
