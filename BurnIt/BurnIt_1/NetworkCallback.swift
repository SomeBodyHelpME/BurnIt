//
//  NetworkCallback.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 30..
//  Copyright © 2017년 이상은. All rights reserved.
//

protocol NetworkCallback {
    
    
    func networkResult(resultData : Any, code:String)
    func networkFailed()
}
