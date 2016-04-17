//
//  AgeDetailsViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/30/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class AgeDetailsViewController: BaseViewController {
    
    private struct StageIcons {
        static let woodenAgeIcon = UIImage(named: "wood-block-icon")
        static let stoneAgeIcon = UIImage(named: "stone-block-icon")
        static let ironAgeIcon = UIImage(named: "iron-block-icon")
        static let goldAgeIcon = UIImage(named: "gold-block-icon")
        static let diamondAgeIcon = UIImage(named: "diamond-block-icon")
    }

    private let GrassBlockIcon = UIImage(named: "grass-block-icon")
    
    @IBOutlet weak var ageIconView: UIImageView!
    @IBOutlet weak var generalRequirementsHeadlineLabel: UILabel!
    @IBOutlet weak var generalRequirementsLabel: UILabel!
    
    @IBOutlet weak var embeddedRequirementsContainer: UIView!
    @IBOutlet weak var containerSegmentControl: UISegmentedControl!

    var requirementViewController: AgeDetailsRequirementsTableViewController?
    
    var stage: ChallengeStages?
    var selectedRequirement: ChallengeStageRequirements? {
        didSet {
            updateEmbeddedRequirementTableView()
        }
    }
    
    var reqArray: NSArray?

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAgeIcon()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configData()
        updateUI()
    }
    
    override func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        updateUI()
    }

//MARK: IBActions
    @IBAction func changeChecklist(sender: UISegmentedControl) {
        updateUI()
    }
    
//MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifiers.embedRequirementsChecklist {
            if let vc = segue.destinationViewController.contentViewController as? AgeDetailsRequirementsTableViewController {
                requirementViewController = vc
            }else {
                log.warning("Attempting to prepare \(SegueIdentifiers.embedRequirementsChecklist) segue but found an unexpected ViewController: \(segue.destinationViewController)")
            }
        }else {
            log.warning("Attempting to prepare for an unknown segue identifier: \(segue.identifier)")
        }
    }
    
//MARK: - Private
    private func configData() {
        guard let age = stage?.description.lowercaseString else {
            log.warning("Stage is not set, unable to configure stage data")
            return
        }

        do {
            let ageData = try CastleChallengeDataManager().dataForAge(age)

            guard let ageReqs = ageData["requirements"] as? NSMutableDictionary else {
                log.error("Requirements data is nil")
                return
            }

            guard let genReqs = ageReqs["general"] as? NSArray else {
                log.error("General Requirement data is nil")
                return
            }

            let newline = String.newline
            var genReqsString = String.empty
            if let genReqsArray = genReqs as? [String] {
                genReqsString = genReqsArray.joinWithSeparator(newline)
                updateGeneralRequirementsLabel(genReqsString)
            }else {
                log.warning("General Requirements is not an array of strings")
            }
        }catch let error as NSError {
            log.error("Error: \(error)")
        }
    }
    
    private func updateAgeIcon() {
        guard let currentStage = stage else {
            //TODO: Try to pop back, maybe pop an error
            log.severe("No Stage is set. Unable to do... anything, actually")
            return
        }

        ageIconView.image = GrassBlockIcon
        
        switch(currentStage) {
        case ChallengeStages.WoodenAge:
            ageIconView.image = StageIcons.woodenAgeIcon
        case ChallengeStages.StoneAge:
            ageIconView.image = StageIcons.stoneAgeIcon
        case ChallengeStages.IronAge:
            ageIconView.image = StageIcons.ironAgeIcon
        case ChallengeStages.GoldAge:
            ageIconView.image = StageIcons.goldAgeIcon
        case ChallengeStages.DiamondAge:
            ageIconView.image = StageIcons.diamondAgeIcon
        }
    }
    
    private func updateUI() {
        switch containerSegmentControl.selectedSegmentIndex {
        case ChallengeStageRequirements.Construction.rawValue:
            selectedRequirement = .Construction
        case ChallengeStageRequirements.Materials.rawValue:
            selectedRequirement = .Materials
        case ChallengeStageRequirements.Treasure.rawValue:
            selectedRequirement = .Treasure
        default: //Do Nothing
            log.error("Attempted to select unknown index: \(containerSegmentControl.selectedSegmentIndex) for requirements segment control")
            selectedRequirement = nil
            break
        }
    
        updateEmbeddedRequirementTableView()
        
        generalRequirementsHeadlineLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleHeadline)
        generalRequirementsLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleBody)
    }
    
    private func updateGeneralRequirementsLabel(text: String) {
        generalRequirementsLabel.text = text
    }
    
    private func updateEmbeddedRequirementTableView() {
        requirementViewController?.requirement = selectedRequirement
        requirementViewController?.stage = stage
    }
}
