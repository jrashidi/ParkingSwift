//
//  SubmitLocationController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/12/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase

class SubmitLocationController: UIViewController, UITextViewDelegate {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var meter: Bool = true
    
    
    let submitBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var cancel: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("X", for: .normal)
        cancel.setTitleColor(UIColor.lightGray, for: .normal)
        cancel.layer.cornerRadius = 5
        cancel.addTarget(self, action: #selector(cancelView), for: .touchUpInside)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        return cancel
    }()
    
    func cancelView() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var submit: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        return button
    }()
    
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
    
    
    lazy var meterSegementedControl: UISegmentedControl = {
        let meter = UISegmentedControl(items: ["No Meter", "Meter"])
        meter.translatesAutoresizingMaskIntoConstraints = false
        meter.addTarget(self, action: #selector(determineMeter), for: .valueChanged)
        return meter
    }()
    
    func determineMeter() {
        if meterSegementedControl.selectedSegmentIndex == 0 {
            meter = true
        } else {
            meter = false
        }
    }
    
    lazy var noteBox: UITextView = {
        let note = UITextView()
        note.text = "Anything Else?"
        note.textColor = UIColor.lightGray
        note.layer.cornerRadius = 5
        note.layer.borderColor = UIColor.gray.cgColor
        note.layer.borderWidth = 1
        note.translatesAutoresizingMaskIntoConstraints = false
        return note
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    

        view.backgroundColor = UIColor.lightGray
        view.isOpaque = true
        
        view.addSubview(submitBox)
        setupSubmitBox()
        noteBox.delegate = self
    }

    func setupSubmitBox() {
        submitBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        submitBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        submitBox.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -450).isActive = true
        
        submitBox.addSubview(submit)
        submitBox.addSubview(cancel)
        submitBox.addSubview(meterSegementedControl)
        submitBox.addSubview(noteBox)
        
        submit.centerXAnchor.constraint(equalTo: submitBox.centerXAnchor).isActive = true
        submit.topAnchor.constraint(equalTo: noteBox.bottomAnchor, constant: 15).isActive = true
        submit.widthAnchor.constraint(equalTo: submitBox.widthAnchor, constant: -20).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cancel.leftAnchor.constraint(equalTo: submitBox.leftAnchor, constant: 10).isActive = true
        cancel.topAnchor.constraint(equalTo: submitBox.topAnchor, constant: 10).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        meterSegementedControl.centerXAnchor.constraint(equalTo: submitBox.centerXAnchor).isActive = true
        meterSegementedControl.topAnchor.constraint(equalTo: cancel.bottomAnchor).isActive = true
        meterSegementedControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        meterSegementedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        noteBox.centerXAnchor.constraint(equalTo: submitBox.centerXAnchor).isActive = true
        noteBox.topAnchor.constraint(equalTo: meterSegementedControl.bottomAnchor, constant: 10).isActive = true
        noteBox.widthAnchor.constraint(equalTo: submitBox.widthAnchor, constant: -20).isActive = true
        noteBox.heightAnchor.constraint(equalToConstant: 100).isActive = true

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
}
