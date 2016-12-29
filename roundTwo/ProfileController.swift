//
//  ProfileImageControllerDelegate.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/28/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase


// This Controller Handles all of the varctions and logic of the Profile Controller View  

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // Log User out
    func handleLogout() {
        let login = LoginController()
        present(login, animated: true, completion: nil)
    }
    
    // Return User to Map
    func returnToMasterMap() {
        let map = MapController()
        let nav = UINavigationController(rootViewController: map)
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - Grab Information from thisUser class and set profile 
    
    //Fetching User Profile Information
    func fetchCurrentUserProfileInfo() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FIRDatabase.database().reference().child("User").child(uid).observe(.childAdded, with: { (snapshot) in
            if let user = snapshot.value as? [String: Any] {
                print(user)
                self.nameLabel.text = user["email"] as! String?
                self.ProfileImageString = user["image"] as! String?
                print(self.ProfileImageString)
                self.PointLabel.text = user["points"] as! String?
            }}, withCancel: nil)
    }
    
    func ImageURLStringToProfilePicture() {
        if let imageURLString = ProfileImageString {
        let url = URL(string: imageURLString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (Data, Response , Error) in
            
            if Error != nil {
                print(Error)
                return
            }
            
            self.ProfilePic.image = UIImage(data: Data!)
        })
        }
    }
    //MARK: - Handling Image Selection, Database and Storage Updating  
    
    // function for Button to pick image for Profile
    func handleImageSelection() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    

    //Delegate method for canceled event of UIImagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Did Not Pick Image")
        dismiss(animated: true, completion: nil)
    }
    
    //Delegate method for successful event of UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //variable to set to picked image
        var selectedImageFromPicker: UIImage?
        
        //image for if user edits the image
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        
        //image if user did not edit image
        } else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = image
    }
        //setting image selected as profile picture
        if let imageSelected = selectedImageFromPicker {
            ProfilePic.image = imageSelected
        }
        
        sendImageToStorage()
        
        dismiss(animated: true, completion: nil)
    }
    
    //send Selected image to Stoage
    func sendImageToStorage() {
        // generate random string for image
        let imageName = NSUUID().uuidString
        
        //where image will live in FireBase Storage
        let storage = FIRStorage.storage().reference().child("ProfileImages").child("\(imageName).png")
        
        
        if let uploadedData = UIImagePNGRepresentation(ProfilePic.image!){
            storage.put(uploadedData, metadata:  nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                guard let imageURL = metadata?.downloadURL()?.absoluteString else {
                    return
                }
                print (metadata?.downloadURL()?.absoluteString)
                
                self.UploadImageToCurrentUserInDatabase(image: imageURL)
            })
        }
    }
    
    //Upload DataBase with Refernce To Image
    private func UploadImageToCurrentUserInDatabase(image: String) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        let ref = FIRDatabase.database().reference(fromURL: "https://roundtwo-9526a.firebaseio.com/")
        let userReference = ref.child("User").child(uid)
        let values = ["image": image] as [String: Any]
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Adding Image to DataBase")
            } else {
                print("Image Added To DataBase")
            }
        })
    }
    
}
