//
//  LoginController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/5/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController, UITextFieldDelegate {
    
    
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
    

    lazy var Loginbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    
    lazy var Registerbutton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self 
        
        view.backgroundColor = UIColor.cyan
        
        view.addSubview(emailContainer)
        view.addSubview(passwordContainer)
        view.addSubview(Loginbutton)
        view.addSubview(Registerbutton)
        
        setupEmailContainer()
        setupPasswordContainer()
        setupButtons()
        
    }
    
    
    func setupEmailContainer() {
        // set x, y, width, height
        emailContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        emailContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailContainer.addSubview(emailField)
        
        emailField.leftAnchor.constraint(equalTo: emailContainer.leftAnchor, constant: 12).isActive = true
        emailField.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 12).isActive = true
        emailField.widthAnchor.constraint(equalTo: emailContainer.widthAnchor)
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
        passwordField.widthAnchor.constraint(equalTo: passwordContainer.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: passwordContainer.heightAnchor)
    }

    func setupButtons() {
        Loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Loginbutton.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 12).isActive = true
        Loginbutton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 12).isActive = true
        Loginbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        Registerbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Registerbutton.topAnchor.constraint(equalTo: Loginbutton.bottomAnchor, constant: 12).isActive = true
        Registerbutton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 12).isActive = true
        Registerbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    

    
}
