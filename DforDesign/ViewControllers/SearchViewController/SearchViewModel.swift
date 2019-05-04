//
//  SearchViewModel.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-04.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
class SearchViewModel: NSObject {
  //  var searchResults: [SearchResult]!
    var search: Search?
    
    func tablViewCount() -> Int {
        if let search = search {
            return search.searchResult.count
        } else {
            return 0
        }
    }
    
    func nameToDisplay(at position: Int) -> String {
        if let search = search {
            return search.searchResult[position].name
        } else {
            return ""
        }
    }
    func search(with string: String, completionHandler:@escaping (_ status: CompletionStatus) -> Void) {
        //TODO: havent passed string to the service
        let urlString = searchingURl
        do {
            try WebServiceCaller.fetchData(from: urlString) { (data, error) in
                if let data = data {
                    do {
                        self.search = try DataTranslator.decodeSearchData(with: data)
                    } catch let error as WebserviceError {
                        completionHandler(.Failure(error.description))
                    }
                    catch let error {
                        completionHandler(.Failure(error.localizedDescription))
                    }
                    
                    //print(self.mainComponents)
                } else {
                    self.search = nil
                }
                completionHandler(.Succes)
            }
        }
        catch  let error as WebserviceError {
            self.search = nil
            completionHandler(.Failure(error.description))
            
        }
        catch let error {
            self.search = nil
            completionHandler(.Failure(error.localizedDescription))
            
        }
    }
}
