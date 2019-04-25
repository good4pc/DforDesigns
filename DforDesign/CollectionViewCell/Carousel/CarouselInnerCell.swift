//
//  CarouselInnerCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-24.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class CarouselInnerCell: UICollectionViewCell {
    
    var position: String! {
        didSet {
            labelCreated.text = position
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0
        
        self.addSubview(labelCreated)
        labelCreated.frame = self.frame
        labelCreated.text = "change"
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": labelCreated]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": labelCreated]))
    }
    
    let labelCreated: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
