//
//  SearchViewController.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-03.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
protocol SearchButtonDelegate: NSObjectProtocol {
    func cancelButtonPressed()
}

class SearchView: UIViewController {
    
    let viewForSearch = UIView()
    var searchBar: UISearchBar!
    weak var delegate: SearchButtonDelegate?
    var toggleView = false
    private let tableViewIdentifier = "searchTableViewIDentifier"
    var viewModel: MainViewModel?
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    let searchTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2.0
        textField.placeholder = "Search Designer, Design Challenges"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    let tableView: UITableView  = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.masksToBounds = true
        return tableView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(searchTextField)
        searchTextField.delegate = self
        
        self.view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.view.addSubview(tableView)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-[cancelButton(50)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": searchTextField,"cancelButton":cancelButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0(40)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": cancelButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": tableView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V1(40)]-5-[V0(200)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V1": searchTextField,"V0": tableView]))
        tableView.isHidden = true
        
        
       
    }
    
    func bindData() {
        viewModel?.searchResults.bind { [weak self] (searchResults)  in
            guard let searchResults = searchResults else {
                return
            }
            if searchResults.count == 0 {
                self?.tableView.reloadData()
                self?.tableView.isHidden = true
            } else {
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }

    @objc func cancelButtonPressed() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.frame.origin.x = self.view.frame.size.width
        }, completion: nil)
    }
    
}
extension SearchView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        
        if range.length == 1 && textField.text?.count == 1 {
            textField.text = nil
            viewModel?.searchResults.value = []
            textField.resignFirstResponder()
        }
        
        if textField.text!.count > 0 {
            //TODO: update search results to model
            if let viewModel = viewModel {
                let searchResult = SearchResult(name: "pc", id: 65)
                viewModel.searchResults.value = [searchResult]
            }
           
            //tableView.reloadData()
        }
        return true
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath)
        cell.textLabel?.text = "pc"
        return cell
    }
   
}

class SearchTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
