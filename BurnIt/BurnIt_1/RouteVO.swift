//
//  RouteVO.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 1..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import ObjectMapper

class RouteVO : Mappable{
    var start_lat : Double?
    var start_long : Double?
    var finish_lat : Double?
    var finish_long : Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        start_lat <- map["start_lat"]
        start_long <- map["start_long"]
        finish_lat <- map["finish_lat"]
        finish_long <- map["finish_long"]
    }
    
    
}
