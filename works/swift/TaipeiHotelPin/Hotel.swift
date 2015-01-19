//
//  Hotel.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/16.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import Foundation
class Hotel {
    var name:String
    var certification_category: String
    var tel: String
    var traffic_info: String?
    var display_addr: String
    var poi_addr: String?
    var X: Int?
    var Y: Int?
    
    init(name:String,certification_category: String,tel: String,traffic_info: String?,display_addr: String,poi_addr: String,X: Int?,Y: Int?
){
       self.name=name
    self.certification_category = certification_category
    self.tel = tel
    self.traffic_info = traffic_info
    self.display_addr = display_addr
    self.poi_addr = poi_addr
    self.X = X
    self.Y = Y
    }
    
    func toJson()->String {
        return ""
    }
}