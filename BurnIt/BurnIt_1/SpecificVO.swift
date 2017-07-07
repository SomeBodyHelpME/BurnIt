//
//  SpecificVO.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 28..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class SpecificVO : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    
    var workplace_lat : Double?
    var workplace_long : Double?
    var home_lat : Double?
    var home_long : Double?
    var task_type : String?
    var cost : Int?
    var workplace_name : String?
    var home_name : String?
    var deadline : String?
    var details : String?
    var phone : String?
    var star : Double?
    var task_idx : Int?
    var clients_members_idx : Int?
    var helpers_members_idx : Int?
    var user_name : String?
    var image_path : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        workplace_lat <- map["workplace_lat"]
        workplace_long <- map["workplace_long"]
        home_lat <- map["home_lat"]
        home_long <- map["home_long"]
        task_type <- map["task_type"]
        cost <- map["cost"]
        workplace_name <- map["workplace_name"]
        home_name <- map["home_name"]
        deadline <- map["deadline"]
        details <- map["details"]
        phone <- map["phone"]
        star <- map["star"]
        task_idx <- map["task_idx"]
        clients_members_idx <- map["clients_members_idx"]
        helpers_members_idx <- map["helpers_members_idx"]
        user_name <- map["user_name"]
        image_path <- map["image_path"]
    }
    
}
