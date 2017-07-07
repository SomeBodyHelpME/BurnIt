//
//  CallerVO.swift
//  Server_test
//
//  Created by 이상은 on 2017. 7. 4..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import ObjectMapper

class ClientVO : Mappable {
    
    var message : String?
    var result : [ClientDetailVO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        result <- map["result"]
    }
}
