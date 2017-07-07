//
//  NetworkModel.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 30..
//  Copyright © 2017년 이상은. All rights reserved.
//


class NetworkModel {
    
    
    //internal -  앱, 모듈, 프레임워크의 내부구조를 칭할때
    internal let baseURL = "http://52.78.182.69:3000"
    
    var view : NetworkCallback
    
    init(_ view:NetworkCallback){
        self.view = view
    }
    
    
    func gsno(_ value:String?)-> String{
        
        if let value_ = value{
            return value_
        }else{
            return ""
        }
        
    }//func gsno
    
    func gino(_ value:Int?) -> Int{
        
        if let value_ = value{
            return value_
        }else{
            return 0;
        }
        
    }//func gino
    
    func gdno(_ value:Double?) -> Double{
        
        if let value_ = value{
            return value_
        }else{
            return 0;
        }
        
    }//func gdno
    

    func gbno(_ value:Bool?)->Bool{
        if let value_ = value{
            return value_
        }else
        {
            return false
        }
        
    }//func gbno
    
    func gfno(_ value:Float?)->Float{
        if let value_ = value{
            return value_
        }else
        {
            return 0
        }
        
    }
    //func gfno
    /*
    func networkResult(resultData: Any, code: String) {
        
    }*/
    func networkFailed() {
        print("Error : Network")
    }
    
    
    
}
