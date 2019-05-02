//
//  BaseViewController.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-30.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

protocol MenuButtonDelegate: NSObjectProtocol {
    func toggleMenuBar()
}

class BaseViewController: UIViewController,MenuButtonDelegate,MenuViewControlDelegate {
    
    var menuViewController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded: Bool = false
    fileprivate func addMainViewController() {
        let main = MainViewController()
        centerController = UINavigationController(rootViewController: main)
        main.delegate = self
        self.view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        print("base view")
        addMainViewController()
        if menuViewController == nil {
            menuViewController = MenuViewController()
            menuViewController.delegate = self
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func closeView() {
        toggleMenuBar()
    }
    
    func toggleMenuBar() {
        
        if !isExpanded {
            UIView.animate(withDuration: 0.5) {
                self.centerController.view.frame.origin.x = self.view.frame.size.width - 100
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.centerController.view.frame.origin.x = 0
            }
        }
        isExpanded = !isExpanded
        
    }
    
    
}
