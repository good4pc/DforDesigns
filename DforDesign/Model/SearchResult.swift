//
//  SearchResult.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
//TODO: - Move
struct Search: Decodable {
    var searchResult: [SearchResult]
}

struct SearchResult: Decodable {
    var name: String
    var id: Int
    var profileImage: String
    var userName: String
    
    var profileImageDownloaded: Data?
    
    mutating func updateImage(with data: Data?) {
        guard let data = data else {
            return
        }
        profileImageDownloaded = data
    }
}
