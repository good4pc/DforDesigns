//
//  DataTranslator.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

class DataTranslator: NSObject {
   static func decodeMainData(with data: Data) -> MainComponenets? {
   
    #if DEBUG
    print("Debug")
    let jsonPAth = Bundle.main.path(forResource: "MainData", ofType: "json")
    guard let url = jsonPAth else {
        return nil
    }
    guard let data = url.takeDataFromUrl() else {
        return nil
    }
    let decoder = JSONDecoder()
    do {
        print(data)
        return try  decoder.decode(MainComponenets.self, from: data)
    } catch let error {
        print(error.localizedDescription)
        return nil
    }
    #else
    print("release")
    
    let decoder = JSONDecoder()
    do {
        return try  decoder.decode([MainComponenets].self, from: data)
    } catch _ {
        return nil
    }
    #endif
    }
}

struct MainData: Decodable {
    
}
