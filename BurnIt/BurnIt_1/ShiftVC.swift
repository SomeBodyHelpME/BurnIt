//
//  ShiftVC.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 7..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import Foundation
import UIKit

class ShiftVC : UIViewController{

    //outlets
    @IBOutlet weak var changeToSupporter: UIButton!
    
    @IBOutlet weak var changeToClient: UIButton!
    
    //아이디 가져오기
   // let user_id = UserDefaults.standard.string(forKey: "user_id")!
    
    /*
     let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
     guard let main = main_storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else{return}
     */

    
    //actions
    //수행자 누르면 수행자로 시작
    @IBAction func changeToSupporter(_ sender: Any) {
        let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
        /*
        if let supporter = main_storyboard.instantiateViewController(withIdentifier: "SupporterMain") as? SupporterMain{
            
            //정보 넘길거 있나?
            
            
            
            //self.present(supporter, animated: true, completion: nil)
        }
        */
        
        let supporterInit = main_storyboard.instantiateViewController(withIdentifier: "SupporterInit") as! SupporterInit
        UserDefaults.standard.set("helper", forKey: "user_role")

        self.present(supporterInit, animated: true, completion: nil)
        
        
    }
    
    
    //의뢰인 누르면 의뢰인으로 시작
    @IBAction func changeToClient(_ sender: Any) {
        let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let clientInit = main_storyboard.instantiateViewController(withIdentifier: "ClientInit") as! ClientInit
        UserDefaults.standard.set("client", forKey: "user_role")
        self.present(clientInit, animated: true, completion: nil)
        
    }
}
