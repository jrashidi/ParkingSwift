//
//  SetParkingController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/18/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import CoreLocation

class SetParkingController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var circle: GMSCircle!
    var regionMonitor: CLCircularRegion!
    var latitude = Double()
    var longitude = Double()
    var locationManager: CLLocationManager!
    
    var region: CLCircularRegion!
    
    func monitorRegion() {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        region = CLCircularRegion(center: location, radius: 25, identifier: "Monitored Region")
        locationManager.startMonitoring(for: region)
        
        print("\(location)")
    }
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.cyan
        button.tintColor = UIColor.clear
        button.setTitle("Submit Location", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitLocation), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let marker: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(named: "icon_me")
        marker.translatesAutoresizingMaskIntoConstraints = false
        marker.contentMode = .scaleAspectFill
        return marker
    }()

    
    func submitLocation() {
        monitorRegion()
        
        let submitLocation = SubmitLocationController()
        submitLocation.latitude = latitude
        submitLocation.longitude = longitude
        
        print("\(latitude), \(longitude)")
        present(submitLocation, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 6)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        circle = GMSCircle(position: camera.target, radius: 15)
        circle.fillColor = UIColor.red.withAlphaComponent(0.5)
        circle.map = mapView
        
        
        view = mapView
        view.addSubview(submitButton)
        view.addSubview(marker)
        
        setupButton()
        setupMarker()
        
    }
    
    func setupMarker() {
        marker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        marker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        marker.widthAnchor.constraint(equalToConstant: 35).isActive = true
        marker.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupButton() {
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("\(position.target.latitude) \(position.target.longitude)")
        circle.position = position.target
        
        self.latitude = position.target.latitude
        self.longitude = position.target.longitude
        let centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        regionMonitor = CLCircularRegion(center: centerCoordinate, radius: 5, identifier: "Testing")
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: ((location.coordinate.latitude) + 0.0001), longitude: ((location.coordinate.longitude)), zoom: 19.0)
            mapView.animate(to: camera)
            print("user latitude = \(self.longitude)")
            print("user longitude = \(self.latitude)")
            locationManager.stopUpdatingLocation()
        } else { return }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("Entered Region")
        } else {return}
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("Exited Region")
        }
    }
    
    // Handle Location Information
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    


}
