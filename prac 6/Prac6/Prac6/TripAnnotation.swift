//
//  TripAnnotation.swift
//  Prac6
//
//  Created by BETTY KWOK on 8/05/2017.
//  Copyright © 2017 BETTY KWOK. All rights reserved.
//

import Foundation
import MapKit


class TripAnnotation : NSObject, MKAnnotation {
    
    var tripId: Int
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var img : UIImage?
    
    init(tripId: Int, trip : Trip , coordinate :
        CLLocationCoordinate2D) {
        self.tripId = tripId
        self.title = trip.tripDestination
        self.subtitle = "\(trip.tripDate)"
        self.coordinate = coordinate
        self.img = trip.destinationImage
    }
}
