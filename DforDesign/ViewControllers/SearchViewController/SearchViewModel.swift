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
enum SearchResultError: Error {
    case invalidTerm(String)
    case underLyingError(NetworkError)
    case invalidData
}

public enum Result <Value, ErrorType: Error> {
    case success(Value)
    case failure(ErrorType)
    
    init(value: Value?, error: ErrorType?) {
        if let error = error {
            self = .failure(error)
        }
        else if let value = value {
            self = .success(value)
        } else {
            fatalError("could not create result")
        }
    }
}

enum NetworkError: Error {
    case fetchFailed(Error)
}

enum SearchResultErrorEnum: Error {
    case invalidError(String)
}

class CallWebservice : UIViewController {
    typealias SearchResult <Value> = Result<Value, SearchResultError>
    typealias JSON = [String: Any]

   
    override func viewDidLoad() {
       
        
    }
    
    func callUrl(with url: URL, completionHandler: @escaping (Result<Data,NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            let dataTaskError = error.map{ NetworkError.fetchFailed($0)}
           // let dataDownloaded = ["value": 9083]
            let result = Result<Data, NetworkError>(value: data, error: dataTaskError)
            completionHandler(result)
        }
        task.resume()
    }
    
    func search(term: String, completionHandler: @escaping(SearchResult<JSON>)-> Void) {
         let url = URL(string: "https://itunes.com/")
        callUrl(with: url!) { (result) in
         //   let convertedResult: SearchResult<JSON> = result
            switch result{
            case .success(let data):
                print(data)
                let newResult = SearchResult<JSON>(value: ["newValue": 939], error: nil)
                completionHandler(newResult)
            case .failure(let error):
                let newResult = SearchResult<JSON>(value: nil, error: .invalidTerm("error"))
                print(error)
                completionHandler(newResult)
            }
        }
    }
}
