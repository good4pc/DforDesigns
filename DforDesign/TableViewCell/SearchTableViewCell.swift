//
//  SearchTableViewCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-04.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var searchResult: SearchResult! {
        didSet {
            DispatchQueue.main.async {
                self.nameLabel.text = self.searchResult.name
            }
            downloadImage()
        }
    }
    
    fileprivate func downloadImage() {
        if let imageDownloaded =  searchResult.profileImageDownloaded {
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: imageDownloaded)
            }
        } else {
            profileImage.downloadImage(from: searchResult.profileImage) { (dataDownloaded) in
                self.searchResult.updateImage(with: dataDownloaded)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        self.addSubview(profileImage)
       
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]-5-[V1(30)]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":nameLabel,"V1":profileImage]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":nameLabel]))
        
        profileImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
