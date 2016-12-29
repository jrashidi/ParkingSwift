//
//  LoginController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/29/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

extension LoginController {
    
    func login() {
        let pushController = MapController()
        let navController = UINavigationController(rootViewController: pushController)
        
        // make sure email and password are not nil
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        
        // sign in user into main app
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (User: FIRUser?, Error) in
            if Error != nil {
                print("Invalid email or password")
                return
            }
            // Login Successful
            self.present(navController, animated: true, completion: nil)
        })
    }
    
    func register() {
        let register = RegisterController()
        present(register, animated: true, completion: nil)
        
    }

}
