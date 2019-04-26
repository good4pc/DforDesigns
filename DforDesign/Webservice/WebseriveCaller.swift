//
//  WebseriveCaller.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

enum WebserviceError: Error {
    case urlError
    case decodingIssue
    case localJsonUrlIssue
    case unableToRetrieveDataFromPath
    var description: String {
        switch self {
        case .urlError:
            return "error in url passed to the methode"
        case .decodingIssue:
            return "Unable to decode data"
        case .localJsonUrlIssue:
            return "local Json URl Issue"
        case .unableToRetrieveDataFromPath:
            return "unable to retrieve data from local path"
        }
    }
}

class WebServiceCaller: NSObject {
    static func fetchData(from url: String, completionHandler:@escaping (Data?,Error?) -> Void ) throws {
        
        guard let url = URL(string: url) else {
            throw WebserviceError.urlError
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let response = urlResponse as! HTTPURLResponse
            if response.statusCode == 200 {
                completionHandler(data,nil)
            }
            else {
                completionHandler(nil,error)
            }
            
        }.resume()
    }
}
