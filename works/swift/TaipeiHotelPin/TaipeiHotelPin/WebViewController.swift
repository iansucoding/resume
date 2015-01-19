//
//  WebViewController.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/17.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var hotel:Hotel!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var googleMapUrlPath = "http://www.google.com.tw/maps/place/\(hotel.display_addr)"
        println(googleMapUrlPath)
        var nsUrl:NSURL = NSURL(string:googleMapUrlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        var request:NSURLRequest = NSURLRequest(URL: nsUrl)
        webView.loadRequest(request)
        
        title = hotel.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
