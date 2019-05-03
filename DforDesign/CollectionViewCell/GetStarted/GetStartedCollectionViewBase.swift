//
//  GetStartedCollectionViewBase.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class GetStartedCollectionViewCellBase: UICollectionViewCell {
    let getStartedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.text = "Get Started"
        return label
    }()
    
    let browseChallenges: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Browse Challenges", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = UIColor(red: 228/256, green: 51/256, blue: 114/256, alpha: 1.0)
        return button
    }()
    
    let browseStore: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Browse Store", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = UIColor.black
        return button
    }()
}
