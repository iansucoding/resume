//
//  UserHotel.swift
//  TaipeiHotelPin
//
//  Created by 蘇百彥 on 2015/1/18.
//  Copyright (c) 2015年 IanSuCoding. All rights reserved.
//

import Foundation
import CoreData

class UserHotel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var tel: String
    @NSManaged var image: NSData
    @NSManaged var isVisited: NSNumber
    @NSManaged var isLike: NSNumber
    @NSManaged var remark: String

}
