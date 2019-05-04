//
//  WinnersCollectionViewCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-29.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit


class WinnersCollectionViewCell: UICollectionViewCell {
    fileprivate var collectionViewCells: [UICollectionViewCell] = []
    fileprivate let winnerCellIdentifier = "winnerCellIDentifier"
    
    var winners: [Winner]! {
        didSet {
            collectionViewForWinners.reloadData()
        }
    }
    let collectionViewForWinners: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
       flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(collectionViewForWinners)
        collectionViewForWinners.register(WinnerCell.self, forCellWithReuseIdentifier: winnerCellIdentifier)
        collectionViewForWinners.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":collectionViewForWinners]))
          self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0":collectionViewForWinners]))
        collectionViewForWinners.delegate = self
        collectionViewForWinners.dataSource = self
      
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WinnersCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return winners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: winnerCellIdentifier, for: indexPath) as! WinnerCell
        cell.winner = winners[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: self.frame.height)
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageWidth = collectionViewCarousel.frame.size.width
//        let page = Int(collectionViewCarousel.contentOffset.x / pageWidth)
//        pageControl.currentPage = page % presenter.carouselCount()
//        currentPage = page
//        currentPagePostion = page % presenter.carouselCount()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        collectionViewCells.append(cell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //collectionViewCells.removeLast()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       /* let offset = (scrollView.contentSize.width / 10.0)/2
        let page = scrollView.contentOffset.x / self.frame.size.width
        let index = Int(page.truncatingRemainder(dividingBy: 10))
       // print(index)
        let originalWidth = 300
        let changingWidth = 100
        
        let difference = CGFloat(originalWidth - changingWidth) / (self.frame.size.width/2)
        print(difference)
        let cell = collectionViewCells[index]
        if let imageView = cell.viewWithTag(323) {
  
            if imageView.bounds.width > 100 {
                print("<<<<<<<<<<<<<<")

            imageView.widthAnchor.constraint(equalToConstant: imageView.bounds.width - difference).isActive = true
                    cell.layoutIfNeeded()
            }
            else {
                if imageView.bounds.width < 300
                {
                    print(">>>>>>>>>>>>>>>>>>>>")
                    imageView.widthAnchor.constraint(equalToConstant: imageView.bounds.width + difference).isActive = true
                        cell.layoutIfNeeded()
                }
            }
            
        }*/
        
    }
    
  
    
    func updateFrame(imageView: UIImageView) {
        
    }
}

