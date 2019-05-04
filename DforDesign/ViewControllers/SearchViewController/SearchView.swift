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
    var searchViewModel = SearchViewModel()
    
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
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let baseViewForSearch: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "searchClose"), for: .normal)
        return button
    }()
    
    
    fileprivate func addViews() {
        self.view.addSubview(baseViewForSearch)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": baseViewForSearch]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0(40)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": baseViewForSearch]))
        
        baseViewForSearch.addSubview(searchTextField)
        searchTextField.delegate = self
        
        baseViewForSearch.addSubview(cancelButton)
        baseViewForSearch.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -5).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0).isActive = true
        
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.view.addSubview(tableView)
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        baseViewForSearch.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-[cancelButton(50)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": searchTextField,"cancelButton":cancelButton]))
        
        baseViewForSearch.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": cancelButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": tableView]))
        
        baseViewForSearch.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V1]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V1": searchTextField]))
        
        tableView.topAnchor.constraint(equalTo: baseViewForSearch.bottomAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        tableView.isHidden = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        addViews()
    }
    
    @objc func cancelButtonPressed() {
        searchTextField.text = nil
        searchTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.frame.origin.x = self.view.frame.size.width
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
        if self.view.frame.origin.x == 0 {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.x = self.view.frame.size.width
            }, completion: nil)
        }
    }
    //MARK: - Searching Method
    func searchUser(with searchText: String) {
        searchViewModel.search(with: searchText) { (status) in
            
            DispatchQueue.main.async {
                switch status {
                case .Succes:
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                case .Failure(let error):
                    print(error.description)
                    self.tableView.isHidden = true
                }
            }
        }
    }
}

//MARK: - Text field delegate

extension SearchView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length == 1 && textField.text?.count == 1 {
            textField.text = nil
            viewModel?.searchResults.value = []
            self.tableView.isHidden = true
            textField.resignFirstResponder()
            return true
        }
        
        guard let searchString = textField.text else {
            return true
        }
        
        searchUser(with: searchString)
        return true
    }
}

//MARK: - TableView delegate

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.tablViewCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! SearchTableViewCell
       // cell.textLabel?.text = searchViewModel.nameToDisplay(at: indexPath.row)
        //cell.textLabel?.textAlignment = .center
        cell.searchResult = searchViewModel.search?.searchResult[indexPath.row]
        return cell
    }
    
}


