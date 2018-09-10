//
//  LocationService.swift
//  Prac6
//
//  Created by BETTY KWOK on 11/05/2017.
//  Copyright © 2017 BETTY KWOK. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol LocationObserver {
    func locationDidChange(newLocations: [CLLocation])
}

class LocationService : NSObject, CLLocationManagerDelegate {
    var locationObservers : [LocationObserver] = []
    var locationManager = CLLocationManager.init()
    static let shared: LocationService = LocationService()

    override private init() {
        super.init()
        locationManager.desiredAccuracy = 100 // meters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func registerLocationObserver(locationObserver : LocationObserver) {
    locationObservers.append(locationObserver)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //notify all observers with the new change
        for observer in locationObservers {
            observer.locationDidChange(newLocations: locations)
        }
    }
    
}
