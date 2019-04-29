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
    case challengeSection = 1
    case chats = 2
}

fileprivate enum SectionHeight: CGFloat {
    case carousel = 220
    case challenge = 398
}

class MainViewController: UIViewController, PresenterDelegate {
    
    fileprivate let cellIdentifierForFeed = "collectionViewCellIdentifier"
    fileprivate let carouselIdentifier = "carouselCellIDentifier"
    fileprivate let challengeIdentifier = "challengeIdentifier"
    
    fileprivate var refreshController = UIRefreshControl()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        //flowLayout.estimatedItemSize = CGSize(width: 200, height: 100)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        return collectionView
    }()
    
    var presenter: MainViewControllerPresenter!
    
    override func viewDidLoad() {
        self.title = "DForDesign"
        initializeCollectionView()
        initializeSearchButtonOnNavigationBar()
        presenter = MainViewControllerPresenter()
        presenter.delegate = self
        callInitialData()
        addRefreshController()
    }
    
    //MARK: - Refresh controller
    
    private func addRefreshController() {
        collectionView.addSubview(refreshController)
        refreshController.addTarget(self, action: #selector(refreshContents), for: .valueChanged)
        
    }
    
    @objc func refreshContents() {
        callInitialData()
        refreshController.endRefreshing()
    }
    
    private func callInitialData() {
        
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
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: challengeIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Updating UI after webservice calls
    
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
        
        return presenter.getNumberOfRowsInMainMenu(in: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Section.carousel.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselIdentifier, for: indexPath) as! CarouselCell
            cell.presenter = presenter
            return cell
            
        case Section.challengeSection.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeIdentifier, for: indexPath) as! ChallengeCell
            if let mainComponent = presenter.mainComponents {
                cell.challenge = mainComponent.challenge
            }
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
        if indexPath.section == Section.carousel.rawValue {
            return CGSize(width: self.view.frame.size.width, height: SectionHeight.carousel.rawValue)
        }
        else if indexPath.section == Section.challengeSection.rawValue {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeIdentifier, for: indexPath) as! ChallengeCell
            cell.contentView.layoutIfNeeded()
            //Y coordinates fecteched from the UI widgets are not showing the exact values that we provided.So manually calculated and added the y cordinates.
            var heightCalculated: CGFloat = 25.0
            
            for view in cell.contentView.subviews {
                heightCalculated = heightCalculated + view.bounds.size.height
            }
            
            if let mainComponent = presenter.mainComponents {
                
                heightCalculated = heightCalculated + mainComponent.challenge.heading.height(constraintedWidth: self.view.bounds.width, font: UIFont.boldSystemFont(ofSize: 18))
                heightCalculated = heightCalculated + mainComponent.challenge.description.height(constraintedWidth: self.view.bounds.width, font: UIFont.systemFont(ofSize: 15))
                
            }
            return CGSize(width: self.view.frame.width, height: heightCalculated)
        }
        
        
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    
}


