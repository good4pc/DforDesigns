//
//  MainViewControllerPresenter.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

protocol MainViewControllerPresentable {
    func callWebservice()
    var mainComponents: MainComponenets {get set}
     func getChallengeTitle() -> String
}

protocol PresenterDelegate: NSObject {
    func updateUI()
}

class MainViewControllerPresenter: NSObject {
    var mainComponents: MainComponenets?
    weak var delegate: PresenterDelegate?
    let carouselMaximum = 9999
    let carouselTiming = 3.5
    
    //MARK: - Carousel data structures
    
    func carouselCount() -> Int {
        if let mainComponents = mainComponents {
            return mainComponents.carouselItems.count
        } else {
            return 0
        }
    }
    
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
    
    func getMainData() {
        //TODO : url should be changed to the approriate value
        
        let urlString = "https://www.google.ca/"
        do {
            try WebServiceCaller.fetchData(from: urlString) { (data, error) in
                if let data = data {
                    do {
                         self.mainComponents = try DataTranslator.decodeMainData(with: data)
                    } catch let error as WebserviceError {
                        print(error.description)
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                   
                    //print(self.mainComponents)
                } else {
                    self.mainComponents = nil
                }
                self.delegate?.updateUI()
            }
        }
        catch  _ as WebserviceError {
            self.mainComponents = nil
            self.delegate?.updateUI()
        }
        catch _ {
            self.mainComponents = nil
            self.delegate?.updateUI()
        }
        
    }
}


