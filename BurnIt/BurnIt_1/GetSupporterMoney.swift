//
//  GetSupporterMoney.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 4..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit

class GetSupporterMoney : UIViewController{
    
    //outlets
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    //actions
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        //네비게이션 컨트롤러 위의 버튼들 색깔 회색으로
        //오렌지로 바뀔때 다시 해줘야돼
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor(rgb:0x95989A)
    }
}
