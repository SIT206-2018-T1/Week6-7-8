//
//  TripsMapViewController.swift
//  Prac6
//
//  Created by BETTY KWOK on 7/05/2017.
//  Copyright © 2017 BETTY KWOK. All rights reserved.
//


import Foundation
import UIKit
import MapKit



class TripsMapViewController: UIViewController, LocationObserver, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.registerLocationObserver(locationObserver: self)

        //load trips from the Utilities class
        Utilities.loadTrip()
        
        //set the mapkitview delegate to the TripsMapViewController
        self.tripsMap.delegate = self
        
        //center the map around current user location 
        tripsMap.setCenter(tripsMap.userLocation.coordinate,
                           animated: true)
        
        //Add a Pin to the map for eavh trip
        for i in 0 ... Utilities.trips.count - 1 {
            let trip = Utilities.trips[i]
            
            //CLGeocoder helps to convert trip destination to coordinates
            CLGeocoder().geocodeAddressString(trip.tripDestination, completionHandler: {
            
                //this is a closure (function), called after resolving the coordinate of the destination
                (placeMark,error) in
                let tripLocation = placeMark![0].location?.coordinate
                self.tripsMap.addAnnotation(TripAnnotation(tripId : i, trip: trip, coordinate: tripLocation!))
            
        })}

        
        

            
            func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                
                //I gt the selected annotationView, get annotation included, and get TripId
                //Trip Id is the index of the trip in the trips array
                let selectedTrip = Utilities.trips[(view.annotation as! TripAnnotation).tripId]
                
                //init the tripInfo viewcontroller. Note "tripInfo" is the view controller Id
                //to do so you need to select the trip Info screen and set its identifier
                let tripInfoVC = (self.storyboard?.instantiateViewController(withIdentifier: "tripInfo") as!TblViewControllerTripInfo)
                
                //no pass the selectTrip
                tripInfoVC.trip = selectedTrip
                
                //show thr trip info screen
                self.present(tripInfoVC, animated: true, completion: nil)
                
            }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            //get id of the annotationView (same as TableCell last week)
            let reuseId = "tripAnnoation"
            
            //if this annotation to view is not TripAnnoation don't continue
            let tripAnnotation : TripAnnotation? = (annotation as? TripAnnotation)
            if tripAnnotation == nil {
                return nil
            }
            
            //get a resuable AnnotationView item
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            //if nil, means first time to use this annotation
            if annotationView == nil {
                //create a new object, and set image and add a button to show more details
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId )
                annotationView?.image = tripAnnotation?.img
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
                annotationView?.canShowCallout = true
            }
            else {
                annotationView!.annotation = tripAnnotation
            }
            return annotationView
        }
        


        
        
       
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tripsMap: MKMapView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func locationDidChange(newLocations: [CLLocation]) {
        self.tripsMap.setCenter(newLocations[0].coordinate, animated: true)
    }
    
}
