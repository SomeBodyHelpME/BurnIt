//
//  CallerDetailVO.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 30..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class ClientDetailVO : Mappable {
    
    var workplace_lat : Double?
    var workplace_long : Double?
    var home_lat : Double?
    var home_long : Double?
    var task_type : String?
    var cost : Int?
    var home_name : String?
    var workplace_name : String?
    var deadline : String?
    var details : String?
    var user_id : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        workplace_lat <- map["workplace_lat"]
        workplace_long <- map["workplace_long"]
        home_lat <- map["home_lat"]
        home_long <- map["home_long"]
        task_type <- map["task_type"]
        cost <- map["cost"]
        home_name <- map["home_name"]
        workplace_name <- map["workplace_name"]
        deadline <- map["deadline"]
        details <- map["details"]
        user_id <- map["user_id"]
        
        
    }
}
