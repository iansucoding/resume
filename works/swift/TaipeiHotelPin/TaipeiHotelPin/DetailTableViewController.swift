//
//  DetailTableViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/16.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var hotel:Hotel!
    var userHotel:UserHotel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if userHotel != nil {
            var imageView = UIImageView()
            imageView.image = UIImage(data: userHotel.image)
            imageView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 150)
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            tableView.tableHeaderView = imageView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userHotel != nil ? 5 : 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as DetailTableViewCell

        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = userHotel != nil ? userHotel.name : hotel.name
        case 1:
            cell.fieldLabel.text = "Tel"
            cell.valueLabel.text = userHotel != nil ? userHotel.tel : hotel.tel
        case 2:
            cell.fieldLabel.text = "Address"
            cell.valueLabel.text = userHotel != nil ? userHotel.address :hotel.display_addr
        case 3:
            cell.fieldLabel.text = "Been Here?"
            cell.valueLabel.text = userHotel.isVisited.boolValue ? "Yes" : "No"
        case 4:
            cell.fieldLabel.text = "Like It?"
            cell.valueLabel.text = userHotel.isLike.boolValue ? "Yes" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }

        return cell
    }
    
    @IBAction func callClick(sender: UIBarButtonItem) {
        var alertCtrl = UIAlertController(title: "Service Unavailable", message: "Sorry, This feature is not yet implemented", preferredStyle: UIAlertControllerStyle.Alert)
        alertCtrl.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertCtrl, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var hotelForNext = userHotel != nil ? Hotel(name: userHotel.name, certification_category: "", tel: userHotel.tel, traffic_info: "", display_addr: userHotel.address, poi_addr: userHotel.address, X: nil, Y: nil) : hotel
        
        if segue.identifier == "showMap" {
            let destinationController = segue.destinationViewController as MapViewController
            destinationController.hotel = hotelForNext
        } else if segue.identifier == "showWeb" {
            let destinationController = segue.destinationViewController as WebViewController
            destinationController.hotel = hotelForNext
        } else if segue.identifier == "addList" {
            let destinationController = segue.destinationViewController as AddTableViewController
            if userHotel != nil {
                destinationController.userHotel = userHotel
            } else {
                destinationController.hotel = hotel
            }
            
        }
    }
    

}
