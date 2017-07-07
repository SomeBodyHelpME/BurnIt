//
//  PopUp.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 2..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit

class PopUp : UIViewController{
    
    var task : SpecificVO?
    var type : String?
    var fee : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(dismissPopUp, at: 0)
        self.view.insertSubview(showDetail, at: 1)
        
        //배달 : "D" (delivery) 청소 : "C" (cleaning) 동행 : "A" (accompany) 줄서주기 : "L" (line) 반려동물 : "P" (pet) 기타 : "E" (etc)
        
        switch task?.task_type {
        case "D"?:
            type = "배달"
        case "C"?:
            type = "청소"
        case "A"?:
            type = "동행"
        case "L"?:
            type = "줄서주기"
        case "P"?:
            type = "반려동물"
        case "E"?:
            type = "기타"
        default: break
        }
        fee = gino(task?.cost)
        
        taskType.text = type
        taskFee.text = "\(fee!)원"
        
    }
    
    
    @IBOutlet weak var showDetail: UIButton!
    @IBAction func showDetail(_ sender: UIButton) {
        //정보 어떻게 넘겨줘야?
        //세부 정보 보여주는 애한테 줘야돼
    }
    
    //데이터 받아와서 찍기
    @IBOutlet weak var taskType: UILabel!
    @IBOutlet weak var taskFee: UILabel!
    
    
    @IBOutlet weak var dismissPopUp: UIButton!
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    //세그에다 이름 붙여서 그때 data 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue"{
        
        let navController = segue.destination as! UINavigationController
        let detailVC = navController.topViewController as! TaskDetails
        detailVC.task = task
        
        }
    }
    
}
