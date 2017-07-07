//
//  AnswerVO.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 30..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerVO : Mappable {
    
    var message : String?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        message <- map["message"]
        
    }
}
