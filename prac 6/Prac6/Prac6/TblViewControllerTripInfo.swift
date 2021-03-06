//
//  TblViewControllerTripInfo.swift
//  Prac6
//
//  Created by BETTY KWOK on 27/04/2017.
//  Copyright © 2017 BETTY KWOK. All rights reserved.
//

import UIKit
import MapKit

class TblViewControllerTripInfo: UITableViewController {
    

        
    var trip : Trip?
    
    @IBOutlet weak var tripDate: UITextField!
    @IBOutlet weak var tripDuration: UITextField!
    @IBOutlet weak var tripDestination: UITextField!
    
    
    //save changes if the user modified the trip data
    
    @IBAction func saveTripInfo(_ sender: Any) {
        trip!.tripDate = Utilities.dateFormatter.date(from: tripDate.text!)!
        trip!.tripDuration = Int(tripDuration.text!)!
        trip!.tripDestination = tripDestination.text!
    }
    
    

    
    //set the trip detils as passed from the trips list view
    
    override func viewWillAppear(_ animated: Bool) {
        if trip != nil {
            tripDate.text = Utilities.dateFormatter.string(for: trip!.tripDate)
            tripDestination.text = trip!.tripDestination
            tripDuration.text = "\(trip!.tripDuration)"
            

                
            }
        }
    
    
            override func viewDidLoad() {
        super.viewDidLoad()
                
                
                func mapView(_ mapView: MKMapView,annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl){
                    let selectedTrip = Utilities.trips[ (view.annotation as! TripAnnotation).tripId]
                    let tripInfoVC = (self.storyboard?.instantiateViewController(withIdentifier:"tripinfo") as! TblViewControllerTripInfo)
                    tripInfoVC.trip = selectedTrip
                    self.present(tripInfoVC, animated:true,completion: nil)
                    
                }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


