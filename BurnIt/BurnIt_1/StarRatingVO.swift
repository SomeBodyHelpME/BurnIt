//
//  StarRatingVO.swift
//  Server_test2
//
//  Created by 이상은 on 2017. 7. 6..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class StarRatingVO: Mappable {
    
    var user_id : String?
    var user_star : Double?
    var user_comment : String?
    var role : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        user_star <- map["user_star"]
        user_comment <- map["user_comment"]
        role <- map["role"]
        
    }
}

