//
//  RequirementTableViewCell.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/17/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class RequirementTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    struct ViewData {
        let requirement: Requirement
    }
    
    var viewData: ViewData? {
        didSet {
            updateItemLabel(viewData?.requirement.description)
            updateQuantityLabel(viewData?.requirement.quantity)
            accessoryTypeForCompleted(viewData?.requirement.completed ?? false)
            
            updateLabelFontForDynamicTextStyles()
        }
    }
    
//MARK: - Lifecycle
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        //NOTE: Clear Labels & Checkmarks
        updateItemLabel(nil)
        updateQuantityLabel(nil)
        accessoryTypeForCompleted(false)
    }

//MARK: - Public
    func loadRequirement(req: NSDictionary) {
        let quantity = req[CastleChallengeKeys.StageRequriementItemKeys.Quantity] as? NSNumber
        let item = req[CastleChallengeKeys.StageRequriementItemKeys.Item] as? String ?? ""
        let completed = req[CastleChallengeKeys.StageRequriementItemKeys.Completed] as? Bool ?? false
        
        updateItemLabel(item)
        updateQuantityLabel(quantity)
        accessoryTypeForCompleted(completed)
        
    }
    
//MARK: - Private
    private func accessoryTypeForCompleted(completed: Bool) {
        if completed {
            accessoryType = UITableViewCellAccessoryType.Checkmark
        }else {
            accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    private func updateItemLabel(itemName: String?) {
        updateLabel(itemLabel, withText: itemName)
    }
    
    private func updateQuantityLabel(quantity: NSNumber?) {
        guard let quantity = quantity as? Int else {
            updateLabel(quantityLabel, withText: "")
            return
        }
        
        if quantity > 0 {
            let quantityString = "\(quantity)"
            updateLabel(quantityLabel, withText: quantityString)
        }else {
            updateLabel(quantityLabel, withText: "")
        }
    }
    
    private func updateLabel(label: UILabel?, withText text: String?) {
        label?.text = text
    }
    
    private func updateLabelFontForDynamicTextStyles() {
        quantityLabel.font =  UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleHeadline)
        itemLabel.font =  UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleBody)
    }
}

extension RequirementTableViewCell.ViewData {
//    init(requirement: Requirement) {
//        self.requirement = requirement
//    }
}
