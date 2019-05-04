//
//  CarouselCollectionViewCell.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-24.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

fileprivate let carouselCellIDentifier = "CarouselCellIdentifier"
class CarouselCell: UICollectionViewCell {
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let collectionViewCarousel: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0.0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    
    var currentPage = 0
    var currentPagePostion = 0
    var viewModel = CarouselViewModel()
    var presenter: MainViewModel! {
        didSet {
            viewModel.initialize(with: presenter)
            collectionViewCarousel.reloadData()
            pageControl.numberOfPages = viewModel.carouselCount()
            
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        addCollectionView()
        startChangingCarousel()
    }
    
    private func addCollectionView() {
        self.addSubview(collectionViewCarousel)
        collectionViewCarousel.frame = self.frame
        collectionViewCarousel.register(CarouselInnerCell.self, forCellWithReuseIdentifier: carouselCellIDentifier)
        collectionViewCarousel.delegate = self
        collectionViewCarousel.dataSource = self
        self.addSubview(pageControl)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": pageControl]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[V0(25)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": pageControl]))
    }
    
    //MARK: - Carousel Animation
    
    private func startChangingCarousel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.movePage()
            self.startChangingCarousel()
        }
    }
    
    private func movePage() {
        if currentPage == viewModel.carouselMaximum - 1 {
            currentPage = 0
            currentPagePostion = 0
            let scrollTo = CGPoint(x: 0, y: 0)
            collectionViewCarousel.setContentOffset(scrollTo, animated: false)
            
        } else {
            if self.currentPage == viewModel.carouselCount() - 1 {
                self.pageControl.currentPage = 0
                currentPagePostion = 0
            } else
            {
                currentPagePostion += 1
                self.pageControl.currentPage = currentPagePostion
            }
            self.currentPage = self.currentPage + 1
            let width = Int(self.frame.width) * (self.currentPage)
            let scrollTo = CGPoint(x: width, y: 0)
            collectionViewCarousel.setContentOffset(scrollTo, animated: true)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - CollectionView delegates

extension CarouselCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.carouselCount() == 0 ? 0: viewModel.carouselMaximum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellIDentifier, for: indexPath) as! CarouselInnerCell
        let position = indexPath.row % viewModel.carouselCount()
        cell.itemDetails = presenter.mainComponents?.carouselItems[position]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = collectionViewCarousel.frame.size.width
        let page = Int(collectionViewCarousel.contentOffset.x / pageWidth)
        pageControl.currentPage = page % viewModel.carouselCount()
        currentPage = page
        currentPagePostion = page % viewModel.carouselCount()
    }
}


