//
//  LocationService.swift
//  Roam
//
//  Created by Darrel Muonekwu on 8/16/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseFirestore

let LocationService = _LocationService()

class _LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    func updateLocation() {
        let locationManager = LocationService.locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        self.latitude = locationManager.location?.coordinate.longitude ?? 0
        self.longitude = locationManager.location?.coordinate.latitude ?? 0
        locationManager.stopUpdatingLocation()
        print(longitude, latitude)
        
    }
    
    func updateLocationWith(latitude: CLLocationDegrees, longitude: CLLocationDegrees ){
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func sendLocationToFirebaseAsRoamer() {
        
        let db = Firestore.firestore()
        
        // Update one field, creating the document if it does not exist.
        db.collection(Collections.ActiveRoamers).document("a@gmail.com").setData([
            DataParams.roamerLatitude: latitude,
            DataParams.roamerLongitude: longitude
            ], merge: true)
    }
    
    func sendLocationToFirebaseAsCustomer() {
        
        let db = Firestore.firestore()
        
        // Update one field, creating the document if it does not exist.
        db.collection(Collections.ActiveRoamers).document("a@gmail.com").setData([
            DataParams.customerLatitude: latitude,
            DataParams.customerLongitude: longitude
            ], merge: true)
        print("updatedWith: \(latitude), \( longitude)")
    }
}
