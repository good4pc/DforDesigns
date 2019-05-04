//
//  DataTranslator.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import Foundation

fileprivate enum JsonFileName: String {
    case mainData = "MainData"
    case searchResults = "SearchingResults"
}

class DataTranslator: NSObject {
    //MARK: - Decode main data set
   static func decodeMainData(with data: Data) throws -> MainComponenets?  {
    //TODO:Refactor
    #if DEBUG
    let jsonPAth = Bundle.main.path(forResource: "MainData", ofType: "json")
    guard let url = jsonPAth else {
        throw WebserviceError.localJsonUrlIssue
    }
    guard let data = url.takeDataFromUrl() else {
        throw WebserviceError.unableToRetrieveDataFromPath
    }
    let decoder = JSONDecoder()
    do {
        return try  decoder.decode(MainComponenets.self, from: data)
    } catch _ {
        throw WebserviceError.decodingIssue
    }
    #else
    let decoder = JSONDecoder()
    do {
        return try  decoder.decode(MainComponenets.self, from: data)
    } catch _ {
        throw WebserviceError.decodingIssue
    }
    #endif
    }
    
    //MARK: - Searching data
    
    static func decodeSearchData(with data: Data) throws -> Search  {
        //TODO:Refactor
        #if DEBUG
        let jsonPAth = Bundle.main.path(forResource: JsonFileName.searchResults.rawValue, ofType: "json")
        guard let url = jsonPAth else {
            throw WebserviceError.localJsonUrlIssue
        }
        guard let data = url.takeDataFromUrl() else {
            throw WebserviceError.unableToRetrieveDataFromPath
        }
        let decoder = JSONDecoder()
        do {
            return try  decoder.decode(Search.self, from: data)
        } catch let error {
        //   print(error.localizedDescription)
            throw WebserviceError.decodingIssue
        }
        #else
        let decoder = JSONDecoder()
        do {
            return try  decoder.decode([SearchResult].self, from: data)
        } catch _ {
            throw WebserviceError.decodingIssue
        }
        #endif
    }
}
