//
//  CarouselViewModel.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation
class CarouselViewModel: NSObject {
    var mainModel: MainViewModel!
    let carouselMaximum = 9999

    func initialize(with mainModel: MainViewModel) {
        self.mainModel = mainModel
    }
    
    //MARK: - Carousel data structures
    
    func carouselCount() -> Int {
        if let mainComponents = mainModel.mainComponents {
            return mainComponents.carouselItems.count
        } else {
            return 0
        }
    }
}
