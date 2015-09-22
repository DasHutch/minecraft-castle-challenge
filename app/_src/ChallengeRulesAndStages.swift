//
//  ChallengeRulesAndStages.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/29/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class ChallengeRulesAndStages: UITableViewController {

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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        csdcObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            
            //TODO: Update table cells...
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
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
    func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorInset = UIEdgeInsetsZero
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
