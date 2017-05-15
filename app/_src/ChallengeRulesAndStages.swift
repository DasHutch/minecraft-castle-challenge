//
//  ChallengeRulesAndStages.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 8/29/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

class ChallengeRulesAndStages: BaseTableViewController {
    
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
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func contentSizeDidChange(newUIContentSizeCategoryNewValueKey: String) {
        updateUI()
    }

//MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == SegueIdentifiers.showAge {
            if let vc = segue.destinationViewController.contentViewController as? DetailViewManagerViewController {
                guard let stage = selectedStage else {
                    log.warning("Attempting to prepare \(SegueIdentifiers.showAge) segue but no age was selected")
                    return
                }

                vc.detailView = DetailViewManagerViewController.DetailViewType.age(stage: stage)
                
            }else {
                log.warning("Attempting to prepare \(SegueIdentifiers.showAge) segue but found an unexpected ViewController: \(segue.destinationViewController)")
            }
        }else if segue.identifier == SegueIdentifiers.showObjective {
            if let vc = segue.destinationViewController.contentViewController as? DetailViewManagerViewController {

                vc.detailView = DetailViewManagerViewController.DetailViewType.objectives

            }else {
                log.warning("Attempting to prepare \(SegueIdentifiers.showObjective) segue but found an unexpected ViewController: \(segue.destinationViewController)")
            }
        }else if segue.identifier == SegueIdentifiers.showRules {
            print("kdsajgkl;dsahgasdklghsadl;kgjdsakl;")
            if let vc = segue.destinationViewController.contentViewController as? DetailViewManagerViewController {

                vc.detailView = DetailViewManagerViewController.DetailViewType.rules

            }else {
                log.warning("Attempting to prepare \(SegueIdentifiers.showRules) segue but found an unexpected ViewController: \(segue.destinationViewController)")
            }
        }else {
            log.warning("Attempting to prepare for an unknown segue identifier: \(segue.identifier)")
        }
    }
    
// MARK: - Private
    private func configTableView() {
        //????: Seems that setting this from the tableView.rowHeight as exists
        //      in storyboard doesn't actually trigger Autolayout / Self Sizing
        tableView.estimatedRowHeight = 44.0 //tableView.rowHeight
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
