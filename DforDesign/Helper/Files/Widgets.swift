//
//  Widgets.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-26.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

private class Widgets {
 
    let getStartedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Get Started"
        return label
    }()
    
    //MARK: - label

    let WinnersAnnounced : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.text = "WINNERS ANNOUNCED"
        return label
    }()
    //MARK: - imageView

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    //MARK: - Button

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
    
    let contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    func addABorderOnLeft() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 1, height: 10)
       // self.view.layer.addSublayer(layer)
        layer.backgroundColor = UIColor.lightGray.cgColor
    }
    //MARK: - tableView
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    class ProfileDetailsCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    /**
 
     self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": imageView]))
     
     self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": imageView]))
     
 **/
}
