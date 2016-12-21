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
    
    var mapView: GMSMapView!
    var marker: GMSMarker!
    var regionMonitor: CLCircularRegion!
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
                marker.map = self.mapView
                
            }
    
           }, withCancel: nil)

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
