//
//  ExtensionControl.swift
//  Server_test
//
//  Created by 이상은 on 2017. 7. 2..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
       
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
    
    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    func networkFailed() {
        let alert = UIAlertController(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
