//
//  ResultVO.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 28..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultVO : Mappable {
    
    var message : String?
    var result : [SpecificVO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        result <- map["result"]
    }
    
}
