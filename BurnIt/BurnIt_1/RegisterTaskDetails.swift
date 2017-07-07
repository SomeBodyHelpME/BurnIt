//
//  RegisterTaskDetails.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 4..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class RegisterTaskDetails : UIViewController, CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource, NetworkCallback {
    
    
    //사용자 아이디
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    //outlet
    @IBOutlet weak var registerTask: UIButton!
    @IBOutlet weak var close: UIBarButtonItem!
    //출발? 목적지? 뭐 어떤거야 outlets
    @IBOutlet weak var destLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    
    
    //textField outlets
    //여기서 받아오는 텍스트들 전부 서버로 올리기
    @IBOutlet weak var taskType: UITextField!
    @IBOutlet weak var taskFee: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var taskContent: UITextView!
    
    //variables
    var locationManager = CLLocationManager()

    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    var startPlace : String?
    var endPlace : String?
    
    //pickerView
    let pickerView = UIPickerView()
    let doingList = ["배달", "청소", "동행", "줄서주기", "반려동물", "기타"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar 앞으로 계속 검정
        //수행인
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        
        
        destLabel.text = startPlace
        workLabel.text = endPlace
        
        initPickerView()
        
    }
    
    //action
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerTask(_ sender: Any) {
        //데이터 받아서 넘기기
        //예외처리랑 같이
        let model = Model(self)
        var type = taskType.text
        let fee = taskFee.text
        //let date = dueDate.text
        //let content = taskContent.text
        
        let content = taskContent.text.replacingOccurrences(of: " ", with: "%20")
        let homeName = startPlace?.replacingOccurrences(of: " ", with: "%20")
        let workName = endPlace?.replacingOccurrences(of: " ", with: "%20")
        let date = dueDate.text?.replacingOccurrences(of: " ", with: "%20")
        
        switch type {
        case "배달"?:
            type = "D"
        case "청소"?:
            type = "C"
        case "동행"?:
            type = "A"
        case "줄서주기"?:
            type = "L"
        case "반려동물"?:
            type = "P"
        case "기타"?:
            type = "E"
        default: break
        }

        
        if (type?.isEmpty)! {
            simpleAlert(title: "입력 오류", msg: "의뢰유형을 입력해주세요.")
        }
        else if (fee?.isEmpty)! {
            simpleAlert(title: "입력 오류", msg: "수행비용을 입력해주세요.")
        }
        else if (date?.isEmpty)! {
            simpleAlert(title: "입력 오류", msg: "기간을 입력해주세요.")
        }
        else if (content.isEmpty) {
            simpleAlert(title: "입력 오류", msg: "의뢰내용을 입력해주세요.")
        }
        else{
            //userID 가져와야
            model.postClientCoordinates(workplace_lat: locationEnd.coordinate.latitude, workplace_long: locationEnd.coordinate.longitude, home_lat: locationStart.coordinate.latitude, home_long: locationStart.coordinate.longitude, task_type: type!, cost: Int(fee!)!, home_name: homeName!, workplace_name: workName!, deadline: date!, details: content, user_id: user_id!)
            
        }
        
    }
    
    
    func networkResult(resultData: Any, code: String) {
        if code == "2-2" {
            //뷰 전환
            if let matching = self.storyboard?.instantiateViewController(withIdentifier: "Matching") as? Matching{
                
                self.present(matching, animated: true, completion: nil)
            }

        }
    }

    
    
    //picker view 생성
    func initPickerView(){
        let barFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        let bar = UIToolbar(frame:barFrame)
        let btnDone = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(selected))
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(notselected))
        
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        bar.setItems([btnCancel,btnSpace,btnDone], animated: true)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        taskType.inputView = pickerView
        taskType.inputAccessoryView = bar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return doingList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return doingList[row]
    }
    func selected(){
        
        let row = pickerView.selectedRow(inComponent: 0)
        taskType.text = doingList[row]
        
        view.endEditing(true)
    }//func selectedImg
    
    func notselected() {
        taskType.text = ""
        view.endEditing(true)
        
    }
    
    
    //textView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }


    
}
