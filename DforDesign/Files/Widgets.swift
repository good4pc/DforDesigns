//
//  Widgets.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-26.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class Widgets {
    let participateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let participateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
