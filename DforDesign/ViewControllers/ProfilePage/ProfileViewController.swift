//
//  ProfileViewController.swift
//  DforDesign
//
//  Created by Prasanth pc on 2019-05-04.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profielTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 100.0
        return tableView
    }()
    
    fileprivate let profileDetailsIdentifier = "profileDetailsIdentifier"
    fileprivate let worksByUserIdentifier = "worksByUserIdentifier"
    
    override func viewDidLoad() {
        self.view.addSubview(profielTableView);
        profielTableView.rowHeight = UITableView.automaticDimension

        profielTableView.estimatedRowHeight = 300.0
        profielTableView.register(ProfileDetailsCell.self, forCellReuseIdentifier: profileDetailsIdentifier)
        profielTableView.register(UsersWorkCell.self, forCellReuseIdentifier: worksByUserIdentifier)

        profielTableView.delegate = self
        profielTableView.dataSource = self
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": profielTableView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[V0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": profielTableView]))
    }
    
}
//MARK: - Tableview delegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
        //return 300

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileDetailsIdentifier, for: indexPath) as! ProfileDetailsCell
           
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: worksByUserIdentifier, for: indexPath) as! UsersWorkCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: worksByUserIdentifier, for: indexPath) as! UsersWorkCell
            return cell
        }
    }
}

class ProfileDetailsCell: UITableViewCell {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
       // imageView.addBorder()
        return imageView
    }()
    
    let name : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Change the name"
        label.numberOfLines = 0
      //  label.addBorder()
        return label
    }()
    
    let designation : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Designation"
        label.numberOfLines = 0
        //label.addBorder()
        return label
    }()
    
    let location : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "kochi,kerala,India"
        label.numberOfLines = 0
      //  label.addBorder()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    //MARK:- Profile Image
    fileprivate func addProfileImage() {
        let widthAndHEight: CGFloat = 70.0
        profileImage.image = #imageLiteral(resourceName: "searchClose")
         // self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": profileImage]))
        profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
          self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[V0(150)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": profileImage]))
    }
    
    fileprivate func addName() {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": name]))
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5.0).isActive = true
        name.bottomAnchor.constraint(equalTo: designation.topAnchor, constant: -5.0).isActive = true
    }
    
    fileprivate func addConstraintsToDesignation() {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": designation]))
        designation.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15.0).isActive = true
        designation.bottomAnchor.constraint(equalTo: location.topAnchor, constant: -5.0).isActive = true
    }
    
    fileprivate func addConstraintsToLocation() {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[V0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["V0": location]))
        location.topAnchor.constraint(equalTo: designation.bottomAnchor, constant: 15.0).isActive = true
        location.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }
    
    func addViews() {
        self.addSubview(designation)
        self.addSubview(name)
        self.addSubview(profileImage)
        self.addSubview(location)
        addProfileImage()
        addName()
        
        addConstraintsToDesignation()
        addConstraintsToLocation()
        //name.heightAnchor.constraint(equalToConstant: 50).isActive = true
     // name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UsersWorkCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
