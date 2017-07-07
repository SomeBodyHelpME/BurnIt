//
//  VC9.swift
//  Server_test
//
//  Created by 이상은 on 2017. 7. 4..
//  Copyright © 2017년 이상은. All rights reserved.
//

import Foundation
import UIKit

class JoinVC : UIViewController, NetworkCallback {
    
    @IBOutlet weak var user_nameTxt: UITextField!
    @IBOutlet weak var user_idTxt: UITextField!
    @IBOutlet weak var user_pwTxt: UITextField!
    @IBOutlet weak var user_phone: UITextField!
    
    var flag : Bool = false
    
    @IBAction func checkBtn(_ sender: Any) {
        if let check_id = user_idTxt.text {
            let model = Model(self)
            model.getJoinCheck(user_id: check_id)
        }
    }
    
    @IBAction func joinBtn(_ sender: Any) {
        let model = Model(self)
        let user_name = self.user_nameTxt.text
        let user_id = self.user_idTxt.text
        let user_pw = self.user_pwTxt.text
        let user_phone = self.user_phone.text
        
        if flag == true {
            
            if (user_name?.isEmpty)! {
                simpleAlert(title: "입력 오류", msg: "user_nameTxt을 입력해주세요.")
            }
            else if (user_pw?.isEmpty)! {
                simpleAlert(title: "입력 오류", msg: "user_pwTxt을 입력해주세요.")
            }
            else if (user_phone?.isEmpty)! {
                simpleAlert(title: "입력 오류", msg: "photoTxt을 입력해주세요.")
            }
            else {
                model.postJoin(user_name: user_name!, user_id: user_id!, user_pw: user_pw!, phone: user_phone!)
            }
            
            
        }
        else {
            simpleAlert(title: "아이디 확인", msg: "아이디를 확인해주세요.")
        }
    }
    
    
    func goToShift(alert: UIAlertAction!){
        if let shift = self.storyboard?.instantiateViewController(withIdentifier: "ShiftVC") as? ShiftVC{
            
            UserDefaults.standard.set(user_idTxt.text, forKey: "user_id")
            
            self.present(shift, animated: true, completion: nil)
        }
    }
    
    //textView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    
    func networkResult(resultData: Any, code: String) {
        
        if code == "2-3" {
            let alert = UIAlertController(title: "가입완료", message: "가입이 완료되었습니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: goToShift)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
            
                    
        else if code == "2-3-1" {
            print("중복 아이디")
            simpleAlert(title: "중복 아이디", msg: "다른 아이디를 입력하세요.")
            flag = false
        }
        else if code == "2-3-2" {
            simpleAlert(title: "아이디 확인", msg: "중복된 아이디가 없습니다.")
            flag = true
        }
        else if code == "2-3-3" {
            flag = false
        }
        
    }
}

