//
//  ChallengeCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-26.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit


class ChallengeCell: ChallengeCellBase {
    
  
    var heightOfCell: CGFloat = 0.0
    
    var challenge: Challenge! {
        didSet {
            DispatchQueue.main.async {
                self.participateLabel.text = self.challenge.heading
                self.descriptionLabel.text = self.challenge.description
                self.downloadImage()
            }
        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
         participateLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
         descriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        print(systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    /*
     override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
     setNeedsLayout()
     layoutIfNeeded()
     participateLabel.preferredMaxLayoutWidth = participateLabel.bounds.size.width
     descriptionLabel.preferredMaxLayoutWidth = descriptionLabel.bounds.size.width
     let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
     var frame = layoutAttributes.frame
     frame.size.height = ceil(size.height + 150)
     layoutAttributes.frame = frame
     return layoutAttributes
     }
     */
    
    
    fileprivate func downloadImage() {
        if let imageDownloaded =  challenge.imageDownloaded {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageDownloaded)
            }
        } else {
            imageView.downloadImage(from: challenge.imageUrl) { (dataDownloaded) in
                self.challenge.updateImage(with: dataDownloaded)
            }
        }
    }
    
    fileprivate func addViewElements() {
        
        
        self.contentView.addSubview(participateLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(participateButton)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateLabel]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":descriptionLabel]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":imageView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[V0]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateButton]))
                
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[V0]-5-[desc]-5-[img(200)]-5-[button(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateLabel,"desc": descriptionLabel,"img":imageView,"button": participateButton]))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addViewElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
