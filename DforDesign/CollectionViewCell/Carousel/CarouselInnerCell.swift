//
//  CarouselInnerCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-24.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class CarouselInnerCell: UICollectionViewCell {
    
    var itemDetails: Item! {
        didSet {
          downloadImage(from: itemDetails.imageUrl)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageViewToCarousel()
    }

    fileprivate func addImageViewToCarousel() {
        self.addSubview(imageView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": imageView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": imageView]))
    }
    
    fileprivate func downloadImage(from url: String) {
        if let imageDownloaded =  itemDetails.imageDownloaded {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageDownloaded)
            }
        } else {
            imageView.downloadImage(from: url) { (dataDownloaded) in
                self.itemDetails.updateImage(with: dataDownloaded)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

