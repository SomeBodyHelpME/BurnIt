//
//  TaskMatchVO.swift
//  Server_test2
//
//  Created by 이상은 on 2017. 7. 6..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class TaskMatchVO : Mappable {
    
    var task_idx : Int?
    var user_id : String?
    

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        task_idx <- map["task_idx"]
        user_id <- map["user_id"]
    }
    
}
