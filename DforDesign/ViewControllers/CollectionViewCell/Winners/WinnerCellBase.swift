//
//  WinnerCellBase.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class WinnerCellBase : UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.borderWidth = 2.0
        //imageView.layer.borderColor = UIColor.red.cgColor
        imageView.tag = 323
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //label.backgroundColor = UIColor.gray
        label.text = "Most popular"
        label.textAlignment = .center
        return label
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 8.0
        
        return view
    }()
    
    let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        // imageView.layer.borderWidth = 2.0
        // imageView.layer.borderColor = UIColor.red.cgColor
        imageView.tag = 323
        imageView.layer.cornerRadius = 20.0
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userNAme : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        //label.backgroundColor = UIColor.gray
        label.text = "Good4pc"
        //        label.textAlignment = .center
        return label
    }()
    
    let commentsNumber : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        // label.backgroundColor = UIColor.gray
        label.text = "1001"
        label.textAlignment = .center
        return label
    }()
    
    let likes : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        //label.backgroundColor = UIColor.gray
        label.text = "15"
        label.textAlignment = .center
        return label
    }()
    

}
