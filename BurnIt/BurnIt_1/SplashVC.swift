//
//  SplashVC.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 26..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import UIKit

class SplashVC : UIViewController,UIGestureRecognizerDelegate {
    
    let ud = UserDefaults.standard
    var delayInSeconds = 2.0
    
    //  var serverAccountSequence : String?
    override func viewDidLoad() {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //2초간의 딜레이 이후 실행
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            let user_id = self.ud.string(forKey: "user_id")
            
            /////////////caller, callee 중 default값을 정해야함 170626
            //실제로는
            //서버에서 가져온 accountSeqeunce 값과 비교해야겠죠
            if user_id != nil {
                //let callee_storyboard = UIStoryboard(name: "Callee", bundle: nil)
                guard let shift = self.storyboard?.instantiateViewController(withIdentifier: "ShiftVC") as? ShiftVC else {return}
                self.present(shift, animated: true, completion: nil)
            }
            else{
                guard let join = self.storyboard?.instantiateViewController(withIdentifier: "JoinVC") as? JoinVC else {return}
                self.present(join, animated: true, completion: nil)
                
                
            }
            
        }//DispatchQueue.main.async
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }
    
    
}
