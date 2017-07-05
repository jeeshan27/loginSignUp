//
//  UserDetailsViewController.swift
//  SignUpPage
//
//  Created by Jeeshan Ali on 03/07/17.
//  Copyright © 2017 Jeeshan Ali. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    var email : String?
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: email!) as? [String : String] {
            
            userName.text = data[UserDefaultKeys.firstName]
            
        }
}
}
