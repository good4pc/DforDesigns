//
//  DForDesignFeedCell.swift
//  SmartBoy
//
//  Created by Prasanth pc on 2019-04-19.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class DForDesignFeedCell: UICollectionViewCell {
    fileprivate let identifier = "DforDesignCellIdentifier"
    fileprivate var paths: [URL?] = []
    var refreshControl = UIRefreshControl()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        self.addSubview(navigationBar)
         navigationBar.addUnderLine()
        collectionView.register(SmartBoyFeedCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":navigationBar]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":collectionView]))
        
        navigationBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.addSubview(refreshControl)
        
        let path = Bundle.main.url(forResource: "IMG_4522", withExtension: "MOV")
        let path2 = Bundle.main.url(forResource: "IMG_4526", withExtension: "MOV")
        paths.append(nil)
        paths.append(nil)
        paths.append(path)
        paths.append(nil)
        paths.append(nil)
        paths.append(nil)
        paths.append(path2)
        paths.append(path2)
        paths.append(nil)
        paths.append(nil)
        paths.append(nil)
        
        //MARK: - Refresh Control
        
        refreshControl.addTarget(self, action: #selector(loadContentsAgain), for: .valueChanged)
    }
    
    @objc func loadContentsAgain() {
        refreshControl.endRefreshing()
        print("loading contents")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        return collectionView
    }()
    
    let navigationBar: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let naviationTitleView = UILabel()
        naviationTitleView.text = "Smart Boy"
        naviationTitleView.translatesAutoresizingMaskIntoConstraints = false
        naviationTitleView.textAlignment = .center
        naviationTitleView.textColor = .lightGray
        view.addSubview(naviationTitleView)
       
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": naviationTitleView]))
        naviationTitleView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        naviationTitleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        naviationTitleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
}

extension DForDesignFeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SmartBoyFeedCell
        cell.path = paths[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       let smartBoyFeedCell = cell as! SmartBoyFeedCell
        smartBoyFeedCell.playVideo()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let smartBoyFeedCell = cell as! SmartBoyFeedCell
        smartBoyFeedCell.stopPlayingVideo()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.self.width, height: 500)
    }
}

