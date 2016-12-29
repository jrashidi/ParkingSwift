//
//  SubmitLocationHandler.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/29/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

extension SubmitLocationController {
    
    func determineMeter() {
        if meterSegementedControl.selectedSegmentIndex == 0 {
            meter = true
        } else {
            meter = false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteBox.text == "Anything Else?"{
            noteBox.text = nil
            noteBox.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteBox.text.isEmpty {
            noteBox.text = "Anything Else"
            noteBox.textColor = UIColor.lightGray
        }
    }
    
    func sendLocation() {
        
        let date = NSDate()
        let ref = FIRDatabase.database().reference(fromURL: "https://roundtwo-9526a.firebaseio.com/")
        let locationsReference = ref.child("Locations").childByAutoId()
        let values = ["latitude": latitude, "longitude": longitude, "meter": meter, "text": noteBox.text, "date": date] as [String : Any]
        locationsReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Found")
                return
            } else {
                print("DataBase Loaded")
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func cancelView() {
        dismiss(animated: true, completion: nil)
    }

}
