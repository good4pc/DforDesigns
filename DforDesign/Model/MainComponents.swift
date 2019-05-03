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
    var winners: [Winner]
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

struct Winner: Decodable {
    var title: String
    var itemImageURl: String
    var userProfileImage: String
    var userName: String
    var comments: String
    var Likes: String
    var profileImageDownloaded: Data?
    var itemImageDownloaded: Data?

    mutating func updateItemImage(with data: Data?) {
        guard let data = data else {
            return
        }
        itemImageDownloaded = data
    }
    
    mutating func updateProfileImage(with data: Data?) {
        guard let data = data else {
            return
        }
        profileImageDownloaded = data
    }
}
