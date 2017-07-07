//
//  ClientProfile.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 6..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit

class ClientProfile : UIViewController{
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
}
