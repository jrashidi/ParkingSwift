//
//  GetParkingController.swift
//  roundTwo
//
//  Created by Justin Rashidi on 12/18/16.
//  Copyright © 2016 J2. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import CoreLocation

class GetParkingController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var Window: Location!
    var mapView: GMSMapView!
    var marker: GMSMarker!
    var latitude = Double()
    var longitude = Double()
    var locationManager: CLLocationManager!
    var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
        let camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 6)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
        view = mapView
        
        fetchLocations()
        
    }
    
    func fetchLocations() {
        FIRDatabase.database().reference().child("Locations").observe(.childAdded, with: { (snapshot) in
               if let dictionary = snapshot.value as? [String: Any] {
                let location = Location()
                location.latitude = dictionary["latitude"] as! Double?
                location.longitude = dictionary["longitude"] as! Double?
                location.note = dictionary["text"] as! String?
                location.meter = dictionary["meter"] as! Int?
                self.locations.append(location)
                
                let position = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
                let marker = GMSMarker(position: position)
                marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.2)
                marker.map = self.mapView
                
            }
    
           }, withCancel: nil)

    }
    
    lazy var editLocation: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.clear
        button.setTitle("Location Not Available", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(editDataBase), for: .touchUpInside)
        return button
    }()
    
    func editDataBase() {
        
    }
    
    var time: UILabel = {
        let time = UILabel()
        time.textColor = UIColor.white
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    func setupView() {
        time.leftAnchor.constraint(equalTo: Window.leftAnchor, constant: 5).isActive = true
        time.topAnchor.constraint(equalTo: Window.topAnchor, constant: -5).isActive = true
        time.heightAnchor.constraint(equalTo: Window.heightAnchor, multiplier: 1/5).isActive = true
        time.widthAnchor.constraint(equalTo: Window.widthAnchor, constant: -20).isActive = true
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        
        let testFrame : CGRect = CGRect(x: 100, y: 200, width: 200, height: 200)
        Window = Location(frame: testFrame)
        Window.layer.borderWidth = 1
        Window.layer.cornerRadius = 5
        Window.backgroundColor = UIColor.darkGray
        time.text = "Time: "
            
        Window.addSubview(time)
        Window.addSubview(editLocation)
        setupView()
        
        return Window
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: ((location.coordinate.latitude) + 0.0001), longitude: ((location.coordinate.longitude)), zoom: 17.0)
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
    
    
    


}
