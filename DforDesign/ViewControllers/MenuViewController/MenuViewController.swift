//
//  MenuViewController.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-04-30.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

protocol MenuViewControlDelegate: NSObjectProtocol {
    func closeView()
}


class MenuViewController: UIViewController {
    weak var delegate: MenuViewControlDelegate?
    var sam: String!
    fileprivate let identifier = "tableViewCellIdentifier"
    fileprivate var section0 = ["Participate Home", "Open Design Challenges", "Past Design Challenges"]
    fileprivate var section1 = ["Communtiy Home", "Browse The Community", "Designers Speak"]
    fileprivate var section2: [String] = []
    fileprivate var headerTitle = ["Participate","Community", "Resell"]
    
    let tableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        tableView.register(MenuBarTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
//MARK: - TableViewDelegates
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return section0.count
        case 1:
            return section1.count
        default:
            return section0.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = section0[indexPath.row]
        case 1:
            cell.textLabel?.text = section1[indexPath.row]
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.closeView()
    }
}
