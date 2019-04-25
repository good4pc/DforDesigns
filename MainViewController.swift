//
//  ViewController.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-24.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
fileprivate enum Section: Int{
    case carousel = 0
    case feed = 1
    case chats = 2
}

fileprivate enum SectionHeight: CGFloat {
    case carousel = 220
}

class MainViewController: UIViewController {

    fileprivate let cellIdentifierForFeed = "collectionViewCellIdentifier"
    fileprivate let carouselIdentifier = "carouselCellIDentifier"
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        self.title = "DForDesign"
        self.view.addSubview(collectionView)
        collectionView.frame = self.view.frame
        
        collectionView.register(DForDesignFeedCell.self, forCellWithReuseIdentifier: cellIdentifierForFeed)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: carouselIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Section.carousel.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselIdentifier, for: indexPath) as! CarouselCell
            return cell
            
        case Section.feed.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierForFeed, for: indexPath) as! DForDesignFeedCell
            return cell
            
        case Section.chats.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierForFeed, for: indexPath) as! DForDesignFeedCell
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierForFeed, for: indexPath) as! DForDesignFeedCell
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
             return CGSize(width: self.view.frame.width, height: SectionHeight.carousel.rawValue)
        }
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}

