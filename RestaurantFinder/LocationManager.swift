//
//  LocationManager.swift
//  RestaurantFinder
//
//  Created by Austin on 7/31/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import CoreLocation

extension Coordinate{
    init( location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var onLocationFix: (Coordinate -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestLocation()
        
    }
    
    func getPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            manager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.description)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        
        let coordinate = Coordinate(location: location)
        if let onLocationFix = onLocationFix {
            onLocationFix(coordinate)
        }
    }
    
}









