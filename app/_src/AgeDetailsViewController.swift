//
//  AgeDetailsViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/30/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class AgeDetailsViewController: UIViewController {
    
    private struct StageIcons {
        static let woodenAgeIcon = UIImage(named: "wood-block-icon")
        static let stoneAgeIcon = UIImage(named: "stone-block-icon")
        static let ironAgeIcon = UIImage(named: "iron-block-icon")
        static let goldAgeIcon = UIImage(named: "gold-block-icon")
        static let diamondAgeIcon = UIImage(named: "diamond-block-icon")
    }
    
    @IBOutlet weak var ageIconView: UIImageView!
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
    
    //NOTE: All PLIST Data
    var plistDict: NSMutableDictionary?
    var reqArray: NSArray?
    
    var csdcObserver: NSObjectProtocol?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NOTE: Only need to call this once on load
        updateAgeIcon()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //NOTE: Config General Req's Data
        configData()
        
        updateUI()
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            //TODO: Update labels, etc...
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if csdcObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(csdcObserver!)
        }
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
        
        let path = FileManager.defaultManager.challengeProgressPLIST()
        plistDict = NSMutableDictionary(contentsOfFile: path)
        if stage != nil && plistDict != nil {
            
            let ageLowerCase = stage!.description.lowercaseString
            let ages = plistDict!["ages"] as? NSMutableDictionary
            if ages != nil {
                
                let age = ages![ageLowerCase] as? NSMutableDictionary
                let ageReqs = age!["requirements"] as? NSMutableDictionary
                guard let genReqs = ageReqs!["general"] as? NSArray else {
                    log.error("General Requirement data is nil, possibly not set yet")
                    return
                }
                
                reqArray = genReqs
                
                updateGeneralRequirementsLabel()
                
                log.verbose("Config'd Data for Age from PLIST")
            }else {
                log.severe("Stage / Data from saved PLIST is missing `ages` dictionary. Possibly, a corrupt plist file?!")
            }
        }else {
            log.warning("Stage / Data from Saved PLIST is nil, unable to retrieve data.")
        }
    }
    
    private func updateAgeIcon() {
        
        guard let currentStage = stage else {
            
            //TODO: Try to pop back, maybe pop an error
            log.severe("No Stage is set. Unable to do... anything, actually")
            return
        }
        
        //NOTE: Start with default Icon
        ageIconView.image = UIImage(named: "grass-block-icon")
        
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
        case 0: //Construction
            
            selectedRequirement = .Construction
        case 1: //Materials
            
            selectedRequirement = .Materials
        case 2: //Treasure
            
            selectedRequirement = .Treasure
        default: //Do Nothing
            
            log.error("Attempted to select unknown index: \(containerSegmentControl.selectedSegmentIndex) for requirements segment control")
            selectedRequirement = nil
            break
        }
        
        updateEmbeddedRequirementTableView()
    }
    
    private func updateGeneralRequirementsLabel() {
        
        let newline = "\n"
        
        var genReqsString = ""
        if let genReqsArray = reqArray as? [String] {
            genReqsString = genReqsArray.joinWithSeparator(newline)
        }
        
        generalRequirementsLabel.text = genReqsString
    }
    
    private func updateEmbeddedRequirementTableView() {
       
        requirementViewController?.requirement = selectedRequirement
        requirementViewController?.stage = stage
    }
}
