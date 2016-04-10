//
//  UIFont+AvenirContentSize.swift
//  MC Castle Challenge
//
//  Created by Gregory Hutchinson on 9/23/15.
//  Copyright © 2015 Gregory Hutchinson. All rights reserved.
//

import UIKit

/** 
 AvenirContentSize Extends UIFont
*/
extension UIFont {
    class func preferredAvenirFontForTextStyle(textStyle: String) -> UIFont {
        
        var fontSize: CGFloat = 16.0
        let contentSizeCategory = UIApplication.sharedApplication().preferredContentSizeCategory
        
        let FontNameRegular = "Avenir-Book"
        let FontNameMedium = "Avenir-Medium"
        
        var fontSizeOffsetDictionary = [String : [String : CGFloat]]()
        
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            
            fontSizeOffsetDictionary = [
                UIContentSizeCategoryExtraSmall :
                [
                    UIFontTextStyleTitle1: -2,
                    UIFontTextStyleTitle2: -2,
                    UIFontTextStyleTitle3: -2,
                    UIFontTextStyleHeadline : -2,
                    UIFontTextStyleSubheadline : -4,
                    UIFontTextStyleBody : -2,
                    UIFontTextStyleCallout : -5,
                    UIFontTextStyleCaption1 : -5,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -4,
                ],
                UIContentSizeCategorySmall :
                [
                    UIFontTextStyleTitle1: -1,
                    UIFontTextStyleTitle2: -1,
                    UIFontTextStyleTitle3: -1,
                    UIFontTextStyleHeadline : -1,
                    UIFontTextStyleSubheadline : -3,
                    UIFontTextStyleBody : -1,
                    UIFontTextStyleCallout : -5,
                    UIFontTextStyleCaption1 : -5,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -4
                ],
                UIContentSizeCategoryMedium :
                [
                    UIFontTextStyleTitle1: 0,
                    UIFontTextStyleTitle2: 0,
                    UIFontTextStyleTitle3: 0,
                    UIFontTextStyleHeadline : 0,
                    UIFontTextStyleSubheadline : -2,
                    UIFontTextStyleBody : 0,
                    UIFontTextStyleCallout : -5,
                    UIFontTextStyleCaption1 : -5,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -4
                ],
                UIContentSizeCategoryLarge :
                [
                    UIFontTextStyleTitle1: 1,
                    UIFontTextStyleTitle2: 1,
                    UIFontTextStyleTitle3: 1,
                    UIFontTextStyleHeadline : 1,
                    UIFontTextStyleSubheadline : -1,
                    UIFontTextStyleBody : 1,
                    UIFontTextStyleCallout : -4,
                    UIFontTextStyleCaption1 : -4,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -3
                ],
                UIContentSizeCategoryExtraLarge :
                [
                    UIFontTextStyleTitle1: 2,
                    UIFontTextStyleTitle2: 2,
                    UIFontTextStyleTitle3: 2,
                    UIFontTextStyleHeadline : 2,
                    UIFontTextStyleSubheadline : 0,
                    UIFontTextStyleBody : 2,
                    UIFontTextStyleCallout : -3,
                    UIFontTextStyleCaption1 : -3,
                    UIFontTextStyleCaption2 : -4,
                    UIFontTextStyleFootnote : -2
                ],
            
                UIContentSizeCategoryExtraExtraLarge :
                [
                    UIFontTextStyleTitle1: 3,
                    UIFontTextStyleTitle2: 3,
                    UIFontTextStyleTitle3: 3,
                    UIFontTextStyleHeadline : 3,
                    UIFontTextStyleSubheadline : 1,
                    UIFontTextStyleBody : 3,
                    UIFontTextStyleCallout : -2,
                    UIFontTextStyleCaption1 : -2,
                    UIFontTextStyleCaption2 : -3,
                    UIFontTextStyleFootnote : -1
                ],
            
                UIContentSizeCategoryExtraExtraExtraLarge :
                [
                    UIFontTextStyleTitle1: 4,
                    UIFontTextStyleTitle2: 4,
                    UIFontTextStyleTitle3: 4,
                    UIFontTextStyleHeadline : 4,
                    UIFontTextStyleSubheadline : 2,
                    UIFontTextStyleBody : 4,
                    UIFontTextStyleCallout : -1,
                    UIFontTextStyleCaption1 : -1,
                    UIFontTextStyleCaption2 : -2,
                    UIFontTextStyleFootnote : 0
                ],

                UIContentSizeCategoryAccessibilityMedium :
                [
                    UIFontTextStyleTitle1: 0,
                    UIFontTextStyleTitle2: 0,
                    UIFontTextStyleTitle3: 0,
                    UIFontTextStyleHeadline : 0,
                    UIFontTextStyleSubheadline : -2,
                    UIFontTextStyleBody : 0,
                    UIFontTextStyleCallout : -5,
                    UIFontTextStyleCaption1 : -5,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -4
                ],

                UIContentSizeCategoryAccessibilityLarge :
                [
                    UIFontTextStyleTitle1: 1,
                    UIFontTextStyleTitle2: 1,
                    UIFontTextStyleTitle3: 1,
                    UIFontTextStyleHeadline : 1,
                    UIFontTextStyleSubheadline : -1,
                    UIFontTextStyleBody : 1,
                    UIFontTextStyleCallout : -4,
                    UIFontTextStyleCaption1 : -4,
                    UIFontTextStyleCaption2 : -5,
                    UIFontTextStyleFootnote : -3
                ],

                UIContentSizeCategoryAccessibilityExtraLarge :
                [
                    UIFontTextStyleTitle1: 2,
                    UIFontTextStyleTitle2: 2,
                    UIFontTextStyleTitle3: 2,
                    UIFontTextStyleHeadline : 2,
                    UIFontTextStyleSubheadline : 0,
                    UIFontTextStyleBody : 2,
                    UIFontTextStyleCallout : -3,
                    UIFontTextStyleCaption1 : -3,
                    UIFontTextStyleCaption2 : -4,
                    UIFontTextStyleFootnote : -2
                ],

                UIContentSizeCategoryAccessibilityExtraExtraLarge :
                [
                    UIFontTextStyleTitle1: 3,
                    UIFontTextStyleTitle2: 3,
                    UIFontTextStyleTitle3: 3,
                    UIFontTextStyleHeadline : 3,
                    UIFontTextStyleSubheadline : 1,
                    UIFontTextStyleBody : 3,
                    UIFontTextStyleCallout : -2,
                    UIFontTextStyleCaption1 : -2,
                    UIFontTextStyleCaption2 : -3,
                    UIFontTextStyleFootnote : -1
                ],

                UIContentSizeCategoryAccessibilityExtraExtraExtraLarge :
                [
                    UIFontTextStyleTitle1: 4,
                    UIFontTextStyleTitle2: 4,
                    UIFontTextStyleTitle3: 4,
                    UIFontTextStyleHeadline : 4,
                    UIFontTextStyleSubheadline : 2,
                    UIFontTextStyleBody : 4,
                    UIFontTextStyleCallout : -1,
                    UIFontTextStyleCaption1 : -1,
                    UIFontTextStyleCaption2 : -2,
                    UIFontTextStyleFootnote : 0
                ]
            ]
        }
        
        //adjust the default font size based on what the User has set in Settings
        guard let fontSizeOffsetCategory = fontSizeOffsetDictionary[contentSizeCategory] else {
            print("WARNING: Unable to find contentSizeCategory mapping for preferredAvenirFont - returning system font descriptor")
            return UIFont.preferredFontForTextStyle(textStyle)
        }
        
        guard let fontSizeOffset = fontSizeOffsetCategory[textStyle] else {
            print("WARNING: Unable to find fontSizeOffset mapping for preferredAvenirFont - returning system font descriptor")
            return UIFont.preferredFontForTextStyle(textStyle)
        }
        
        fontSize += fontSizeOffset
        
        //choose the font weight
        if textStyle == UIFontTextStyleHeadline || textStyle == UIFontTextStyleSubheadline {
            return UIFont(descriptor: UIFontDescriptor(name: FontNameRegular, size: fontSize), size: 0.0)
        }else {
            return UIFont(descriptor: UIFontDescriptor(name: FontNameMedium, size: fontSize), size: 0.0)
        }
    }
}
