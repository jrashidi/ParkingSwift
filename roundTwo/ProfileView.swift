//
//  ProfileController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/22/16.
//  Copyright © 2016 J2. All rights reserved.



import UIKit
import Firebase

class ProfileController: UIViewController {
    
    var ProfileImageString: String? = nil
    
    // Button to set profile picture
    lazy var takePicture: UIButton = {
       let button = UIButton()
        button.setTitle("Set Profile Picture", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleImageSelection), for: .touchUpInside)
        return button
    }()

    // Image View For Profile Picture
    let ProfilePic: UIImageView = {
        let pic = UIImageView()
        pic.layer.cornerRadius = 100
        pic.layer.masksToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.image = UIImage()
        return pic
    }()
    
    // Label for UserName
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your UserName"
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var PointLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(nameLabel)
        view.addSubview(ProfilePic)
        view.addSubview(takePicture)
        view.addSubview(PointLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(returnToMasterMap))
        setupView()
        fetchCurrentUserProfileInfo()
        ImageURLStringToProfilePicture()
    }
    

    
    //Sets up View of Controller
    func setupView() {
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        takePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePicture.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -40).isActive = true
        takePicture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        takePicture.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ProfilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfilePic.topAnchor.constraint(equalTo: takePicture.bottomAnchor, constant: 50).isActive = true
        ProfilePic.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ProfilePic.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        PointLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PointLabel.topAnchor.constraint(equalTo: ProfilePic.bottomAnchor, constant: 50).isActive = true
        PointLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        PointLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
}
