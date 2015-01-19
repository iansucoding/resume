//
//  AddTableViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/18.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var hotel:Hotel!
    var isBeenHere = false
    var isLikeIt = false
    var isExited = false
    var userHotel:UserHotel!

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hotelTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var yesBeenHereButton: UIButton!
    @IBOutlet weak var noBeenHereButton: UIButton!
    @IBOutlet weak var yesLikeItButton: UIButton!
    @IBOutlet weak var noLikeItButton: UIButton!
    @IBOutlet weak var remarkTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        println("userHotel == nil : \(userHotel == nil)")
        if userHotel == nil {
            //  檢查是否已經存在 UserHotel 實體中
            if let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
                let fetchRequest = NSFetchRequest(entityName: "UserHotel")
                fetchRequest.predicate = NSPredicate(format: "name=%@", hotel.name)
                var existedUserHotls = context.executeFetchRequest(fetchRequest, error: nil) as [UserHotel]
                if existedUserHotls.count == 1 {
                    userHotel = existedUserHotls[0]
                    fillExitedHotel()
                } else {
                    hotelTextField.text = hotel.name
                    addressTextField.text = hotel.display_addr
                    phoneTextField.text = hotel.tel
                }
            }
        } else {
            fillExitedHotel()
            
        }
 
        title = isExited ? "Update" : "Add"
    }
    func fillExitedHotel(){
        isExited = true
        imageView.image = UIImage(data: userHotel.image)
        hotelTextField.text = userHotel.name
        addressTextField.text = userHotel.address
        phoneTextField.text = userHotel.tel
        if userHotel.isVisited.boolValue {
            self.updateYesOrNo(yesBeenHereButton)
        }
        if userHotel.isLike.boolValue {
            self.updateYesOrNo(yesLikeItButton)
        }
        remarkTextView.text = userHotel.remark
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateYesOrNo(sender: UIButton) {
        if sender == yesBeenHereButton {
            isBeenHere = true
            yesBeenHereButton.backgroundColor = UIColor.redColor()
            noBeenHereButton.backgroundColor = UIColor.lightGrayColor()
        } else if sender == noBeenHereButton {
            isBeenHere = false
            noBeenHereButton.backgroundColor = UIColor.redColor()
            yesBeenHereButton.backgroundColor = UIColor.lightGrayColor()
        } else if sender == yesLikeItButton {
            isLikeIt = true
            yesLikeItButton.backgroundColor = UIColor.redColor()
            noLikeItButton.backgroundColor = UIColor.lightGrayColor()
        } else if sender == noLikeItButton {
            isLikeIt = false
            noLikeItButton.backgroundColor = UIColor.redColor()
            yesLikeItButton.backgroundColor = UIColor.lightGrayColor()
        }
    }
    @IBAction func saveClick(sender: UIBarButtonItem) {
        // Form validation
        if hotelTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the hotel . The field is mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        if let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            if !isExited {
                userHotel = NSEntityDescription.insertNewObjectForEntityForName("UserHotel", inManagedObjectContext: context) as UserHotel
            }
            userHotel.name = self.hotelTextField.text
            userHotel.address = self.addressTextField.text
            userHotel.tel = self.phoneTextField.text
            userHotel.isVisited = self.isBeenHere
            userHotel.isLike = self.isLikeIt
            userHotel.image = UIImagePNGRepresentation(imageView.image)
            userHotel.remark = self.remarkTextView.text
            var e:NSError?
            if context.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
        performSegueWithIdentifier("unwindToMyHotelList", sender: self)
    }
    
    
    // MARK: - Table view data source
    
    //  點選一個 cell 來挑選照片
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    // 使用者從照片庫挑選照片後，這個代理方法會被呼叫
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
