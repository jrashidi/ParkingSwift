//
//  ProfileImageControllerDelegate.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/28/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase


extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // function for Button to pick image for Profile
    func handleImageSelection() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func sendImageToDataBase() {
        let storage = FIRStorage.storage().reference().child("MyImage.PNG")
        
        if let uploadedData = UIImagePNGRepresentation(ProfilePic.image!){
        storage.put(uploadedData, metadata:  nil, completion: { (metadata, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            print (metadata)
        })
        }
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
        
        sendImageToDataBase()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
