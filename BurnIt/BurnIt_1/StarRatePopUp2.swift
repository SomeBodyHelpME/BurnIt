//
//  StarRatePopUp.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 3..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit
import Cosmos

class StarRatePopUp2 : UIViewController, NetworkCallback{
    
    @IBOutlet weak var cosmosview: CosmosView!
    
    @IBOutlet weak var howWas: UILabel!
    @IBOutlet weak var comment: UITextField!
    
    var task : SpecificVO?
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    let user_role = UserDefaults.standard.string(forKey: "user_role")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cosmosview.rating = 4
        cosmosview.settings.fillMode = .half
        cosmosview.settings.starSize = 33
        cosmosview.settings.starMargin = 5.5
        
        self.view.insertSubview(dismissPopUp, at: 0)
        self.view.insertSubview(sendRate, at: 1)
        
       // howWas.text = (task?.user_name!)!+" 수행인은 어떠셨나요?"
         howWas.text = "이상은 수행인은 어떠셨나요?"

    }
    
    @IBOutlet weak var sendRate: UIButton!
    @IBAction func sendRate(_ sender: Any) {
        /*
        let model = Model(self)
        model.postStar(user_id: user_id!, user_star: cosmosview.rating, user_comment: comment.text!, role: user_role!)
 
        self.performSegue(withIdentifier: "unwindToMain", sender: self)*/
    }
    
    func networkResult(resultData: Any, code: String) {
        
    }
    
    
    @IBOutlet weak var dismissPopUp: UIButton!
    @IBAction func dismissPopUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //textView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}
