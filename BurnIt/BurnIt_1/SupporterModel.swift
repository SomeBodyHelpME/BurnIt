//
//  SupporterModel.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 1..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON

class SupporterModel : NetworkModel {
    func sendRoute(start_lat:Double, start_long:Double, finish_lat:Double, finish_long:Double){
        let URL : String = "\(baseURL)/task"
        
        let body : [String:Double] = [
            "start_lat":start_lat,
            "start_long":start_long,
            "finish_lat":finish_lat,
            "finish_long":finish_long
        ]
        
        Alamofire.request(URL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: nil).
    }
}
