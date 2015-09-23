//
//  ChallengeRulesAndStages.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/29/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class ChallengeRulesAndStages: UITableViewController {
    
    @IBOutlet weak var objectiveAndPlotStaticCellLabel: UILabel!
    @IBOutlet weak var rulesStaticCellLabel: UILabel!
    @IBOutlet weak var woodenAgeStaticCellLabel: UILabel!
    @IBOutlet weak var stoneAgeStaticCellLabel: UILabel!
    @IBOutlet weak var ironAgeStaticCellLabel: UILabel!
    @IBOutlet weak var goldAgeStaticCellLabel: UILabel!
    @IBOutlet weak var diamondAgeStaticCellLabel: UILabel!
    
    private struct ChallengeRulesAndStagesTableViewSections {
        static let HowToPlay = 0
        static let Stages = 1
    }
    
    var selectedStage: ChallengeStages?
    var csdcObserver: NSObjectProtocol?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            self.updateUI()
            self.tableView.reloadData()
        }
        
        updateUI()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if csdcObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(csdcObserver!)
        }
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == SegueIdentifiers.showAge {
            if let vc = segue.destinationViewController.contentViewController as? AgeDetailsViewController {
                
                vc.stage = selectedStage
                
            }else {
                log.warning("Attempting to prepare \(SegueIdentifiers.showAge) segue but found an unexpected ViewController: \(segue.destinationViewController)")
            }
        }else if segue.identifier == SegueIdentifiers.showObjective {
            log.verbose("TODO: Implement Show How to Play")
        }else if segue.identifier == SegueIdentifiers.showRules {
            //NOTE: No nothing is needed, RulesViewController handles its self...
        }else {
            log.warning("Attempting to prepare for an unknown segue identifier: \(segue.identifier)")
        }
    }
    
    // MARK: - Private
    private func configTableView() {
        
        tableView.estimatedRowHeight = 44.0//tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    private func updateUI() {
       
        objectiveAndPlotStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        rulesStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        woodenAgeStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        stoneAgeStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        ironAgeStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        goldAgeStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
        diamondAgeStaticCellLabel.font = UIFont.preferredAvenirFontForTextStyle(UIFontTextStyleTitle2)
    }
}

// MARK: - UITableViewDelegate
extension ChallengeRulesAndStages {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {
            log.severe("No Cell available for IndexPath: \(indexPath)")
            return
        }
        
        if indexPath.section == ChallengeRulesAndStagesTableViewSections.HowToPlay {
            
            //NOTE: Let the Segue in Storyboard do its thing...
            
        }else if indexPath.section == ChallengeRulesAndStagesTableViewSections.Stages  {
            
            switch(indexPath.row) {
    
                case ChallengeStages.WoodenAge.rawValue:
                    
                    selectedStage = .WoodenAge
                
                case ChallengeStages.StoneAge.rawValue:
                
                    selectedStage = .StoneAge
                
                case ChallengeStages.IronAge.rawValue:
                
                    selectedStage = .IronAge
                
                case ChallengeStages.GoldAge.rawValue:
                
                    selectedStage = .GoldAge
                
                case ChallengeStages.DiamondAge.rawValue:
                
                    selectedStage = .DiamondAge
                
                default:
                    
                    log.warning("Attempting to select unknown stage for IndexPath: \(indexPath)")
                    selectedStage = nil
                    
                break
            }
            
            performSegueWithIdentifier(SegueIdentifiers.showAge, sender: cell)
            
        }else {
            log.error("Unknown TableView Section - cell selected, unable to perform segue.")
        }
    }
}
