//
//  RegisterController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/6/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    var points = 0
    
    let emailContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = UIColor.white
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.layer.cornerRadius = 5
        ic.layer.masksToBounds = true
        return ic
    }()
    
    let passwordContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = UIColor.white
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.layer.cornerRadius = 5
        ic.layer.masksToBounds = true
        return ic
    }()
    
    let confirmPasswordContainer: UIView = {
       let pc = UIView()
        pc.backgroundColor = UIColor.white
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.layer.cornerRadius = 5
        pc.layer.masksToBounds = true
        return pc
    }()
    
    let emailField: UITextField = {
        let ef = UITextField()
        ef.placeholder = "Email"
        ef.translatesAutoresizingMaskIntoConstraints = false
        return ef
    }()
    
    let passwordField: UITextField = {
        let pf = UITextField()
        pf.placeholder = "Password"
        pf.translatesAutoresizingMaskIntoConstraints = false
        pf.isSecureTextEntry = true
        return pf
    }()
    
    
    let confirmPasswordField: UITextField = {
        let pf = UITextField()
        pf.placeholder = "Retype Password"
        pf.translatesAutoresizingMaskIntoConstraints = false
        pf.isSecureTextEntry = true
        return pf
    }()
    
    lazy var Loginbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        view.addSubview(emailContainer)
        view.addSubview(passwordContainer)
        view.addSubview(confirmPasswordContainer)
        view.addSubview(Loginbutton)
        
        setupEmailContainer()
        setupPasswordContainer()
        setupButtons()
        
    }
    
    
    func setupEmailContainer() {
        // set x, y, width, height
        emailContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        emailContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        emailContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailContainer.addSubview(emailField)
        
        
        emailField.leftAnchor.constraint(equalTo: emailContainer.leftAnchor, constant: 12).isActive = true
        emailField.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 12).isActive = true
        emailField.rightAnchor.constraint(equalTo: emailContainer.rightAnchor)
        emailField.heightAnchor.constraint(equalTo: emailContainer.heightAnchor)
    }
    
    
    func setupPasswordContainer() {
        
        passwordContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 12).isActive = true
        passwordContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        passwordContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordContainer.addSubview(passwordField)
        
        
        passwordField.leftAnchor.constraint(equalTo: passwordContainer.leftAnchor, constant: 12).isActive = true
        passwordField.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 12).isActive = true
        passwordField.rightAnchor.constraint(equalTo: passwordContainer.rightAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: passwordContainer.heightAnchor)
        
        confirmPasswordContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmPasswordContainer.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 12).isActive = true
        confirmPasswordContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        confirmPasswordContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        confirmPasswordContainer.addSubview(confirmPasswordField)
        
        
        confirmPasswordField.leftAnchor.constraint(equalTo: confirmPasswordContainer.leftAnchor, constant: 12).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordContainer.topAnchor, constant: 12).isActive = true
        confirmPasswordField.widthAnchor.constraint(equalTo: confirmPasswordContainer.widthAnchor).isActive = true
        confirmPasswordField.heightAnchor.constraint(equalTo: confirmPasswordContainer.heightAnchor)
        
    }
    
    func setupButtons() {
        Loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Loginbutton.topAnchor.constraint(equalTo: confirmPasswordContainer.bottomAnchor, constant: 12).isActive = true
        Loginbutton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 12).isActive = true
        Loginbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
}
