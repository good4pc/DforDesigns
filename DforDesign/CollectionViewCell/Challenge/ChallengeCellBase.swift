//
//  ChallengeCellBase.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class ChallengeCellBase: UICollectionViewCell {
    let participateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let participateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitle("PARTICIPATE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    let baseView: UIView = {
        let view = UIView()
        view.tag = 334
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
