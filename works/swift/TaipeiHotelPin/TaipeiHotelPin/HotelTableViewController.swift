//
//  HotelTableViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/16.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit

class HotelTableViewController: UITableViewController,UISearchResultsUpdating {
    var hotelCollection = [Hotel]()
    var hotelResultCollection = [Hotel]()
    
    var hotelService:HotelService!
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    var hotelCache:NSCache = NSCache()
    var searchController:UISearchController!
    
    @IBAction func unwindToMyHotelList(segue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        // 取得遠端json資料 (參考：https://www.youtube.com/watch?v=Ixk93yx-v28)
        hotelService = HotelService()
        if let hotelData = hotelCache.objectForKey("hotelCollection") as? [Hotel] {
            // 直接讀 Cache 的資料
            hotelCollection = hotelData
        } else {
            self.getHotels()
        }
        
        
        // Loading
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        // Refresh
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.grayColor()
        refreshControl?.tintColor = UIColor.orangeColor()
        refreshControl?.addTarget(self, action: "getHotels", forControlEvents: UIControlEvents.ValueChanged)
        
        // Search
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
    }
    func getHotels(){
        hotelService.getHotels { (response) -> Void in
            self.loadHotels(response as NSArray)
        }
    }
    func loadHotels(hotels:NSArray){
        for hotel in hotels {
            var hotel = hotel as NSDictionary
            var name = hotel["name"] as String
            var certification_category = hotel["certification_category"] as String
            var tel = hotel["tel"] as String
            var traffic_info = hotel["traffic_info"] as? String
            var display_addr = hotel["display_addr"] as String
            var poi_addr  = hotel["poi_addr"] as String
            var X = (hotel["X"] as? String)?.toInt()
            var Y = (hotel["Y"] as? String)?.toInt()
            var hotelObject = Hotel(name: name, certification_category: certification_category, tel: tel, traffic_info: traffic_info, display_addr: display_addr, poi_addr: poi_addr, X: X, Y: Y)
            
            hotelCollection.append(hotelObject)
        }
        dispatch_async(dispatch_get_main_queue()){
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            self.refreshControl?.endRefreshing()
            // 存到 Cache
            self.hotelCache.setObject(self.hotelCollection, forKey: "hotelCollection")
        }
    }
    // 自訂搜尋方法
    func filterContentForSearchText(searchText:String){
        hotelResultCollection = hotelCollection.filter({
            (hotel:Hotel) -> Bool in
            let hotelMatch1 = hotel.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let hotelMatch2 = hotel.display_addr.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            if hotelMatch1 != nil || hotelMatch2 != nil {
                return true
            }
            return false
        })
    }
    // 實作 UISearchResultsUpdating 方法
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
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
        
        if searchController.active {
            return hotelResultCollection.count
        } else {
            return hotelCollection.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        var hotel = searchController.active ? hotelResultCollection[indexPath.row] : hotelCollection[indexPath.row]
        cell.textLabel?.text = hotel.name
        cell.detailTextLabel?.text = hotel.display_addr

        return cell
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
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as DetailTableViewController
                destinationController.hotel = searchController.active ?  hotelResultCollection[indexPath.row]:  hotelCollection[indexPath.row]
            }

            
        }
    }
    

}
