//
//  ProfileController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/22/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    var name: String?
    var email: String?
    var password: String?
    var points: Int? 
    
    
    let ProfilePic: UIImageView = {
        let pic = UIImageView()
        pic.image = UIImage()
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your UserName"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        view.addSubview(nameLabel)
        view.addSubview(ProfilePic)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(returnToMasterMap))
        setupView()
    }
    
    func handleLogout() {
        let login = LoginController()
        present(login, animated: true, completion: nil)
    }
    
    func returnToMasterMap() {
        let map = MapController()
        let nav = UINavigationController(rootViewController: map)
        present(nav, animated: true, completion: nil)
    }
    
    func setupView() {
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -40).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        ProfilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfilePic.centerYAnchor.constraint(equalTo: view.topAnchor, constant: -40).isActive = true
        ProfilePic.widthAnchor.constraint(equalToConstant: 150).isActive = true
        ProfilePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}
