//
//  GetStartedCollectionViewCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-01.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//
import UIKit

class GetStartedCollectionViewCell: GetStartedCollectionViewCellBase {
   
    
    private var views: [String: UIView] = [:]
    override init(frame: CGRect) {
        super.init(frame: frame)
        views = ["getStartedLabel": getStartedLabel,
                 "browseChallenges": browseChallenges,
                 "browseStore": browseStore]
        self.addSubview(getStartedLabel)
        self.addSubview(browseChallenges)
        self.addSubview(browseStore)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[getStartedLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[getStartedLabel(80)]-10-[browseChallenges(60)]-10-[browseStore(60)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[browseChallenges]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[browseStore]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
