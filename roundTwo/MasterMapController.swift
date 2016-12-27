//
//  ViewController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/5/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    lazy var mapSegementedController: UISegmentedControl = {
        let map = UISegmentedControl(items: ["Set Parking", "Find Parking"])
        map.translatesAutoresizingMaskIntoConstraints = false
        map.tintColor = UIColor.blue
        map.selectedSegmentIndex = 0
        map.addTarget(self, action: #selector(setSegmentedControl), for: .valueChanged)
        return map
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    func setSegmentedControl() {
        let set = SetParkingController()
        let get = GetParkingController()
        if mapSegementedController.selectedSegmentIndex == 0 {
            remove(asChildViewController: get)
            add(asChildViewController: set)
        } else {
            remove(asChildViewController: set)
            add(asChildViewController: get)
        }
    }
    
    private func setupView() {
        setSegmentedControl()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(sendToProfile))
        navigationItem.titleView = mapSegementedController
        
        
    }
    
    func sendToProfile() {
        
        let profile = ProfileController()
        let navProfile = UINavigationController(rootViewController: profile)
        present(navProfile, animated: true, completion: nil)
    }
    
    
    


}

