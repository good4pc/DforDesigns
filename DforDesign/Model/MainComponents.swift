//
//  MainComponents.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

struct MainComponenets: Decodable {
    var carouselItems: [Item]
    var string: String
}


struct Item: Decodable {
    var imageUrl: String
    var itemUrl: String
}
