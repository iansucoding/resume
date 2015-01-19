//
//  HotelService.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/16.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import Foundation

class HotelService {
    var settings:Settings!
    
    init(){
        settings = Settings()
    }
    func getHotels(callback:(NSArray)->Void){
        self.request(settings.viewHotels, callback: callback)
    }
    func request(url:String, callback:(NSArray)->Void){
        
        var nsUrl = NSURL(string: url)
        // Session Task
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl!) {
            (data,response,error) in
            var error:NSError?
            // 將 json 解析後放到 NSArray (如果是物件則改為 NSDictionary)
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
            
            callback(response)
        }
        task.resume() // 啟動任務
    }
}