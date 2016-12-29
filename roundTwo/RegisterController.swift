//
//  RegisterController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/29/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

extension RegisterController {
    
    func login() {
        let main = MapController()
        let nav = UINavigationController(rootViewController: main)
        createUser()
        self.present(nav, animated: true, completion: nil)
    }
    
    func createUser() {
        if (passwordField.text != confirmPasswordField.text) {
            let alert = UIAlertController(title: "Problem With Password", message: "Passwords Do Not Match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            guard let email = emailField.text, let password = passwordField.text else {return}
            FIRAuth.auth()?.createUser(withEmail: email , password: password, completion: { (user: FIRUser?, error) in
                if error != nil {
                    print(error)
                }
                guard let uid = user?.uid else {return}
                self.addUserToDataBase(uid: (uid))
                
            })}
    }
    
    func addUserToDataBase(uid: String) {
        guard let email = emailField.text  else {return}
        let ref = FIRDatabase.database().reference(fromURL: "https://roundtwo-9526a.firebaseio.com/")
        let userReference = ref.child("User").child(uid)
        let values = ["email": email, "points": points] as [String: Any]
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Adding User to DataBase")
            } else {
                print("User Added To DataBase")
            }
        })
    }
    
}
