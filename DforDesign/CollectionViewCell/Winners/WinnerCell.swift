//
//  WinnerCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-29.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class WinnerCell: WinnerCellBase {
    
    fileprivate func downloadImage() {
        if let imageDownloaded = winner.itemImageDownloaded {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageDownloaded)
            }
        } else {
            imageView.downloadImage(from: winner.itemImageURl) { (data) in
                self.winner.updateItemImage(with: data)
            }
        }
        
        
        if let profileImageDownloaed = winner.profileImageDownloaded {
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: profileImageDownloaed)
            }
        } else {
            profileImage .downloadImage(from: winner.userProfileImage) { (data) in
                self.winner.updateProfileImage(with: data)
            }
        }
        
    }
    
    var winner: Winner! {
        didSet {
            
            DispatchQueue.main.async {
                self.downloadImage()
                self.userNAme.text = self.winner.userName
                self.title.text = self.winner.title
                self.commentsNumber.text = self.winner.comments
                self.likes.text = self.winner.Likes
            }
        }
    }
   
    
    fileprivate func addContentsToCell() {
        profileView.addSubview(profileImage)
        profileView.addSubview(userNAme)
        profileView.addSubview(commentsNumber)
        profileView.addSubview(likes)
        
        profileView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[V0(40)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":profileImage]))
        
        profileView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[V0(40)]-5-[V1]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":profileImage,"V1": userNAme]))
        profileView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V0(40)]-5-[V1(25)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": userNAme,"V1":commentsNumber]))
        
        
        commentsNumber.leftAnchor.constraint(equalTo: userNAme.leftAnchor).isActive = true
        commentsNumber.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        likes.leadingAnchor.constraint(equalTo: commentsNumber.trailingAnchor, constant: 5).isActive = true
        likes.topAnchor.constraint(equalTo: commentsNumber.topAnchor).isActive = true
        likes.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        profileView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V0(40)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":profileImage]))
        
        
        
        
        contentsView.addSubview(imageView)
        contentsView.addSubview(profileView)
        contentsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[V0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":profileView]))
        
        contentsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[V0]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":imageView]))
        contentsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[V0]-10-[V1(80)]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":imageView,"V1":profileView]))
        
        self.contentView.addSubview(title)
        self.contentView.addSubview(contentsView)
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[V0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":title]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[V0(30)]-10-[V1(290)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":title,"V1":contentsView]))
        
        contentsView.widthAnchor.constraint(equalToConstant: 230).isActive = true
        contentsView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addContentsToCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
