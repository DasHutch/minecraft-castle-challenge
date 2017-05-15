//
//  DetailViewManagerViewController.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 7/31/16.
//  Copyright © 2016 Gregory Hutchinson. All rights reserved.
//

import UIKit

class DetailViewManagerViewController: UIViewController {
    enum DetailViewType {
        case objectives
        case rules
        case age(stage: ChallengeStages)
    }

    var detailView: DetailViewType! {
        willSet {
            if newValue == nil { fatalError() }
        }

        didSet {
            switch detailView! {
            case .objectives:
                performSegueWithIdentifier("show_objectives_detail", sender: self)
            case .rules:
                performSegueWithIdentifier("show_rules_detail", sender: self)
            case .age(let stage):
                print(stage)
                performSegueWithIdentifier("show_ages_detail", sender: self)
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
