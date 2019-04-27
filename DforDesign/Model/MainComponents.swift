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
    var challenge: Challenge
}


struct Item: Decodable {
    var imageUrl: String
    var itemUrl: String
    //calculated variable for storing the downloaded image
    var imageDownloaded: Data?
    
    mutating func updateImage(with data: Data?) {
        guard let data = data else {
            return
        }
        imageDownloaded = data
    }
 }

struct Challenge: Decodable {
    var heading: String
    var description: String
    var imageUrl: String
    var imageDownloaded: Data?
    
    mutating func updateImage(with data: Data?) {
        guard let data = data else {
            return
        }
        imageDownloaded = data
    }
}
