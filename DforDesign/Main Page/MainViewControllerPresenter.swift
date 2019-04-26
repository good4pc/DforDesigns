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
}

protocol PresenterDelegate: NSObject {
    func updateUI()
}

class MainViewControllerPresenter: NSObject {
    var mainComponents: MainComponenets!
    weak var delegate: PresenterDelegate?
    func getMainData() {
        let urlString = "https://www.google.ca/"
        do {
            try WebServiceCaller.fetchData(from: urlString) { (data, error) in
                if let data = data {
                    self.mainComponents = DataTranslator.decodeMainData(with: data)
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


