//
//  TblViewControllerTrips.swift
//  Prac6
//
//  Created by BETTY KWOK on 27/04/2017.
//  Copyright © 2017 BETTY KWOK. All rights reserved.
//

import UIKit

class TblViewControllerTrips: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.loadTrip()
        //push the table view below the bar
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    //how many sections in my table - currently I want one section
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //hoe many rows trips in my array

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Utilities.trips.count;
    }
    
    
    //fill the table view
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        cell.textLabel?.text = "\(Utilities.trips[indexPath.row].tripDestination), \(Utilities.trips[indexPath.row].tripDuration)"
        cell.detailTextLabel?.text = "\(Utilities.dateFormatter.string(from: Utilities.trips[indexPath.row].tripDate))"
        cell.imageView?.image = Utilities.trips[indexPath.row].destinationImage
        return cell
    }

    
    //Trigger the segue for the selected cell, and send the trip object to the details view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTripDetails", sender: Utilities.trips[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTripDetails" {
            //I created a segue from the cell to the Trip Info and changed the identifiter to segueTripDetails
            (segue.destination as! TblViewControllerTripInfo).trip = (sender as! Trip)
        }
    }


    //called in the unwind segue - exit Trip Info
    @IBAction func unWindSegue(segue : UIStoryboardSegue)
    {
        self.tableView.reloadData()
    }
    
    //editing table view - tape left on the table to see
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:
        IndexPath) {
        if editingStyle == .delete {
            Utilities.trips.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
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

}
