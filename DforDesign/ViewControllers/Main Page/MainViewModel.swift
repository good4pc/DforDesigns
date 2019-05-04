//
//  MainViewModel.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-02.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

enum CompletionStatus {
    case Succes
    case Failure(String)
    
    func description() -> String {
        switch self {
        case .Succes:
            return "Succeeded"
        case .Failure(let errorDescription):
            return "Failed with description- \(errorDescription)"
        }
    }
}
//TODO: - to be removed
extension MainViewModel {
    func startAccessCodeBinder() {
        accessCode.value = "\(drand48())"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
           // self?.accessCode.value = "\(drand48())"
            self?.startAccessCodeBinder()
        }
    }
}


class MainViewModel: NSObject {
    
    
    var accessCode: Box<String?> = Box(nil)
    var searchResults: Box<[SearchResult]?> = Box(nil)
    
    override init() {
        super.init()
       // startAccessCodeBinder()
    }
    
    var mainComponents: MainComponenets?
    let carouselTiming = 3.5
  
    //MARK: challenge
    
    func getNumberOfRowsInMainMenu(in section: Int) -> Int {
        if let mainComponents = mainComponents {
            if section == 0 {
                return (mainComponents.carouselItems.count > 0) ?  1 :  0
            } else if section == 1 {
                return 1
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    
    func initialize(completionHandler:@escaping (_ status: CompletionStatus) -> Void) {
        let urlString = baseUrl
        do {
            try WebServiceCaller.fetchData(from: urlString) { (data, error) in
                if let data = data {
                    do {
                        self.mainComponents = try DataTranslator.decodeMainData(with: data)
                    } catch let error as WebserviceError {
                        completionHandler(.Failure(error.description))
                        }
                    catch let error {
                         completionHandler(.Failure(error.localizedDescription))
                    }
                    
                    //print(self.mainComponents)
                } else {
                    self.mainComponents = nil
                }
                completionHandler(.Succes)
            }
        }
        catch  let error as WebserviceError {
            self.mainComponents = nil
            completionHandler(.Failure(error.description))

        }
        catch let error {
            self.mainComponents = nil
            completionHandler(.Failure(error.localizedDescription))
            
        }
    }
    
}
