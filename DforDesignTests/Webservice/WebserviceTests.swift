//
//  WebserviceTests.swift
//  DforDesignTests
//
//  Created by Prasanth pc on 2019-04-25.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import XCTest
@testable import DforDesign
class WebserviceTests: XCTestCase {
    var mainViewController: MainViewController!
    
    override func setUp() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
       
    }
    
    func testCarouselCount() {
      //  XCTAssertEqual(mainViewController.presenter.carouselCount(), 3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWebserviceCall() {
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
