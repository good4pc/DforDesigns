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
    case challengeSection1 = 1
   // case challengeSection2 = 2
    case winners = 2
    case getStarted = 3
}

fileprivate enum SectionHeight: CGFloat {
    case carousel = 220
    case challenge = 398
}

class MainViewBase: UIViewController {
    
  
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        
        //flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //flowLayout.sectionInsetReference = .fromLayoutMargins
        
        //flowLayout.estimatedItemSize = CGSize(width: 200, height: 100)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        //collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
}

class MainViewController: MainViewBase, SearchButtonDelegate {
    weak var delegate: MenuButtonDelegate?
    fileprivate let cellIdentifierForFeed = "collectionViewCellIdentifier"
    fileprivate let carouselIdentifier = "carouselCellIDentifier"
    fileprivate let challengeIdentifier = "challengeIdentifier"
    fileprivate let winnerHeaderIDentifier = "winnerHeaderIdentifier"
    fileprivate let winnersCollectionViewCellIdentifier = "winnersCollectionViewCellIdentifier"
    fileprivate let getStartedIdentifier = "getStartedIdentifier"

    fileprivate var refreshController = UIRefreshControl()
    
    var viewModel = MainViewModel()
    lazy var searchVc = SearchView()
    
    override func viewDidLoad() {
        self.title = "DForDesign"
        initializeCollectionView()
        initializeSearchButtonOnNavigationBar()
        addRefreshController()
        addNavigationMenuButton()
        loadData()
//        viewModel.accessCode.bind { (value) in
//           // print("value changed")
//        }
    }
    //MARK: Loading data from service
    
    func loadData() {
        self.view.addActivityIndicator()
        viewModel.initialize { (status) in
            self.view.removeActivityIndicator()
            switch status {
            case .Succes:
                DispatchQueue.main.async {
                     self.collectionView.reloadData()
                }
               
            case .Failure(let errorDescription):
                //TODO: Add alert controller here
                print(errorDescription)
                break
            }
        }
    }
    
  
    private func addNavigationMenuButton() {
        let menuButton = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(showMenuBar))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func showMenuBar() {
        delegate?.toggleMenuBar()
    }
    
    //MARK: - Refresh controller
    
    private func addRefreshController() {
        collectionView.addSubview(refreshController)
        refreshController.addTarget(self, action: #selector(refreshContents), for: .valueChanged)
    }
    
    @objc func refreshContents() {
       // callInitialData()
        loadData()
        refreshController.endRefreshing()
    }
    
    fileprivate func initializeSearchButtonOnNavigationBar() {
        let searChBarButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem = searChBarButton
    }
    
    //MARK: - Search ButtonClicked
    
    func cancelButtonPressed() {
        searchButtonClicked()
    }
    
    @objc func searchButtonClicked() {
        //self.performSegue(withIdentifier: "SearchViewController", sender: self)
        
        let viewForSearchView = SearchView()
        self.view.window!.addSubview(viewForSearchView.view)
        viewForSearchView.viewModel = viewModel
        //viewForSearchView.bindData()
        addChild(viewForSearchView)
        viewForSearchView.didMove(toParent: self)
        viewForSearchView.view.frame.origin.x = self.view.frame.size.width
        viewForSearchView.view.frame.origin.y = self.navigationController?.navigationBar.frame.origin.y ?? 0.0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            viewForSearchView.view.frame.origin.x = 0.0
        }, completion: nil)
 
    }
    
    fileprivate func initializeCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        collectionView.register(DForDesignFeedCell.self, forCellWithReuseIdentifier: cellIdentifierForFeed)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: carouselIdentifier)
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: challengeIdentifier)
        
        collectionView.register(WinnerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: winnerHeaderIDentifier)
        
        collectionView.register(WinnersCollectionViewCell.self, forCellWithReuseIdentifier: winnersCollectionViewCellIdentifier)
        
         collectionView.register(GetStartedCollectionViewCell.self, forCellWithReuseIdentifier: getStartedIdentifier)

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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.getNumberOfRowsInMainMenu(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: winnerHeaderIDentifier, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: self.view.bounds.width, height: 80)
        } else {
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Section.carousel.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselIdentifier, for: indexPath) as! CarouselCell
            cell.presenter = viewModel
            return cell
            
        case Section.challengeSection1.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeIdentifier, for: indexPath) as! ChallengeCell
            if let mainComponent = viewModel.mainComponents {
                cell.challenge = mainComponent.challenge
            }
            return cell
            
//        case Section.challengeSection2.rawValue:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeIdentifier, for: indexPath) as! ChallengeCell
//            if let mainComponent = presenter.mainComponents {
//                cell.challenge = mainComponent.challenge
//            }
//            return cell
            
        case Section.getStarted.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getStartedIdentifier, for: indexPath) as! GetStartedCollectionViewCell
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: winnersCollectionViewCellIdentifier, for: indexPath) as! WinnersCollectionViewCell
            if let mainComponent = viewModel.mainComponents {
                cell.winners = mainComponent.winners
            }
            return cell
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == Section.carousel.rawValue {
            return CGSize(width: self.view.frame.size.width, height: SectionHeight.carousel.rawValue)
        }
        else if indexPath.section == Section.challengeSection1.rawValue {
            
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeIdentifier, for: indexPath) as! ChallengeCell
            cell.contentView.layoutIfNeeded()
            //Y coordinates fecteched from the UI widgets are not showing the exact values that we provided.So manually calculated and added the y cordinates.
            var heightCalculated: CGFloat = 25.0
            
            for view in cell.contentView.subviews {
                heightCalculated = heightCalculated + view.bounds.size.height
            }
            
            if let mainComponent = viewModel.mainComponents {
                
                heightCalculated = heightCalculated + mainComponent.challenge.heading.height(constraintedWidth: self.view.bounds.width, font: UIFont.boldSystemFont(ofSize: 18))
                heightCalculated = heightCalculated + mainComponent.challenge.description.height(constraintedWidth: self.view.bounds.width, font: UIFont.systemFont(ofSize: 15))
                
            }
        return CGSize(width: self.view.frame.width, height: heightCalculated)
        }
        else if indexPath.section == Section.getStarted.rawValue {
            return CGSize(width: self.view.frame.width, height: 240 )
        }
        
        
        return CGSize(width: self.view.frame.width, height: 350 )
    }
    
    
}




