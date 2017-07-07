//
//  TaskAccepted.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 2..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit

class TaskAccepted : UIViewController{

    //outlets
    @IBOutlet weak var showTaskMap: UIButton!
    @IBOutlet weak var clientPhoto: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var makeCall: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var taskType: UILabel!
    @IBOutlet weak var taskFee: UILabel!
    @IBOutlet weak var taskContents: UILabel!
    
    
    
    //actions
   /* @IBAction func showTaskMap(_ sender: Any) {
    }*/
    @IBAction func makeCall(_ sender: Any) {
        
    }
    @IBAction func message(_ sender: Any) {
    }
    
    
    
    //다음 뷰에 데이터 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAcceptedMap"{
            
            let mapVC = segue.destination as! AcceptedTaskMap
            mapVC.task = task
            
        }
    }

    
    //variables
    //매칭된 의뢰가 여기로 들어와
    var task : SpecificVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        clientPhoto.image = #imageLiteral(resourceName: "default_photo")
        clientName.text = task?.user_name!
        clientPhone.text = task?.phone!
        taskType.text = task?.task_type!
        taskFee.text = "\(gino(task?.cost))원"
        taskContents.text = task?.details!
        
    }
    
    
}
