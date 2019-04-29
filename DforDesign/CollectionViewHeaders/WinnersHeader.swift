//
//  WinnersHeader.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-29.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class WinnerHeader: UICollectionReusableView {
    let winnersAnnounced : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.text = "WINNERS ANNOUNCED"
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "The votes are in and here are the winners"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(winnersAnnounced)
        self.addSubview(descriptionLabel)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":winnersAnnounced]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":descriptionLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[V0(30)][V1(30)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":winnersAnnounced,"V1":descriptionLabel]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
