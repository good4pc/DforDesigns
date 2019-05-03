//
//  MainViewModelTests.swift
//  DforDesignTests
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import XCTest

class MainViewModelTests: XCTestCase {
    var mainComponent: MainComponenets?
    var viewModel = MainViewModel()
    var viewModelWithNilData = MainViewModel()
    fileprivate func readDataFromJsonFile() {
        do {
            mainComponent = try DataTranslator.decodeMainData(with: Data())
            viewModel.mainComponents = mainComponent
        }catch {
            mainComponent = nil
        }
    }
    
    override func setUp() {
        readDataFromJsonFile()
    }
    
    func testNumberOfRowsInMainMenu() {
        XCTAssertEqual(viewModel.getNumberOfRowsInMainMenu(in: 0), 1)
        XCTAssertEqual(viewModel.getNumberOfRowsInMainMenu(in: 1), 1)
        XCTAssertEqual(viewModel.getNumberOfRowsInMainMenu(in: 2), 1)
        XCTAssertEqual(viewModelWithNilData.getNumberOfRowsInMainMenu(in: 0), 0)
    }
    
    func testWebservice() {
       
            let url = "https://www.google.ca/"
            let expectation = XCTestExpectation(description: "running webservice")
            
            do {
                try WebServiceCaller.fetchData(from: url, completionHandler: { (data, error) in
                    expectation.fulfill()
                })
            }
            catch let error as WebserviceError {
                print(error.description)
            }
            catch let error {
                print("some error happened",error.localizedDescription)
            }
            wait(for: [expectation], timeout: 30.0)
            
        
    }
}
