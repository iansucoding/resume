//
//  MyTableViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/18.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    var fetchResultCtrl:NSFetchedResultsController!
    var myHotelCollection:[UserHotel]!
    
    
    
    @IBAction func unwindToMyHotelList(segue:UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var fetchRequest = NSFetchRequest(entityName: "UserHotel")
        var sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            fetchResultCtrl = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultCtrl.delegate = self
            var e:NSError?
            var result = fetchResultCtrl.performFetch(&e)
            myHotelCollection = fetchResultCtrl.fetchedObjects as [UserHotel]
            if result != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }

        }
    }
    // 內容有變化時，下面 NSFetchedResultsControllerDelegate 的方法會被呼叫
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        myHotelCollection = controller.fetchedObjects as [UserHotel]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.endUpdates()
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myHotelCollection.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        var myHotel = myHotelCollection[indexPath.row]
        cell.textLabel?.text = myHotel.name
        cell.detailTextLabel?.text = myHotel.address

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
                let myHotelToDelete = self.fetchResultCtrl.objectAtIndexPath(indexPath) as UserHotel
                context.deleteObject(myHotelToDelete)
                var e:NSError?
                if context.save(&e) != true {
                    println("insert error: \(e!.localizedDescription)")
                    return
                }
            }
            // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        if segue.identifier == "addMine" {
            var hotel = Hotel(name: "My New Hotel", certification_category: "", tel: "", traffic_info: "", display_addr: "", poi_addr: "",X:nil, Y:nil)
            let destinationController = segue.destinationViewController as AddTableViewController
            destinationController.hotel = hotel
        } else if segue.identifier == "showMine" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                var myHotel:UserHotel = myHotelCollection[indexPath.row] as UserHotel
                let destinationController = segue.destinationViewController as DetailTableViewController
                destinationController.userHotel =  myHotel
                
            }
        }

    }
    
}
