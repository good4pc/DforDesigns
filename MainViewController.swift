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

class MainViewController: UIViewController, PresenterDelegate {

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
    
    var presenter: MainViewControllerPresenter!
    
    override func viewDidLoad() {
        self.title = "DForDesign"
        initializeCollectionView()
        initializeSearchButtonOnNavigationBar()
        callInitialData()
    }
    
    private func callInitialData() {
        presenter = MainViewControllerPresenter()
        presenter.delegate = self
        presenter.getMainData()
    }
    
    fileprivate func initializeSearchButtonOnNavigationBar() {
        let searChBarButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem = searChBarButton
    }
    
    @objc func searchButtonClicked() {
        
        self.performSegue(withIdentifier: "SearchViewController", sender: self)
    }
    
    fileprivate func initializeCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.frame = self.view.frame
        collectionView.register(DForDesignFeedCell.self, forCellWithReuseIdentifier: cellIdentifierForFeed)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: carouselIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateUI() {
        DispatchQueue.main.async {
           self.collectionView.reloadData()
        }
        
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
            cell.presenter = presenter
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

