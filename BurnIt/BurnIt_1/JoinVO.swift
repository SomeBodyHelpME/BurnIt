//
//  JoinVO.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 28..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class JoinVO : Mappable {
    
    var user_name : String?
    var user_id : String?
    var user_pw : String?
    var phone : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user_name <- map["user_name"]
        user_id <- map["user_id"]
        user_pw <- map["user_pw"]
        phone <- map["phone"]
    }
}
