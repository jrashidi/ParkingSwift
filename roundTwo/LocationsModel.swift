//
//  LocationsModel.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/20/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import GoogleMaps

class Location: UIView {
    var latitude: Double?
    var longitude: Double?
    var meter: Int?
    var note: String?
    
    lazy var editLocation: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Location", for: UIControlState.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(editDataBase), for: .touchUpInside)
        return button
    }()
    
    func editDataBase() {
        
    }
    
    func setupButton() {
        self.addSubview(editLocation)
        editLocation.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        editLocation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        editLocation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        editLocation.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    }
}
