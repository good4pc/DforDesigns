//
//  ChallengeCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-26.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class ChallengeCell: UICollectionViewCell {
    
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
    
    
    //    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    //        setNeedsLayout()
    //        layoutIfNeeded()
    //
    //        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
    //        var frame = layoutAttributes.frame
    //        frame.size.height = ceil(size.height)
    //        layoutAttributes.frame = frame
    //        print(ceil(size.height))
    //        return layoutAttributes
    //    }
    
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
        //self.addProgressIndicator()
        self.addSubview(baseView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":baseView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":baseView]))
        baseView.addSubview(participateLabel)
        
        baseView.addSubview(descriptionLabel)
        baseView.addSubview(imageView)
        baseView.addSubview(participateButton)
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateLabel]))
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":descriptionLabel]))
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":imageView]))
        //baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateButton]))
        participateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        participateButton.centerXAnchor.constraint(equalToSystemSpacingAfter: baseView.centerXAnchor, multiplier: 0).isActive = true
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[V0]-5-[desc]-5-[img(200)]-10-[button(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":participateLabel,"desc": descriptionLabel,"img":imageView,"button": participateButton]))
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
