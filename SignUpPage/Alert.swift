//
//  Alert.swift
//  SignUpPage
//
//  Created by Jeeshan Ali on 05/07/17.
//  Copyright © 2017 Jeeshan Ali. All rights reserved.
//

import Foundation
import UIKit

enum Messages: String {
    case firstName = "Enter First Name"
    case lastName = "Enter Last Name"
    case email = "Enter Email ID"
    case password = "Enter Correct Password"
    case confirmPassword = "Password and Confirm Password are not equal"
    case userName = "Enter Username"
    case isValidEmail = "Enter Valid Passowrd"
    case isValidPassword = "Enter Valid Password"
    case empty = "Enter All The Details"
    case alreadyExist = "Try New UserName"
}
    

extension UIViewController {
    func alert(title : String = " Invalid" ,message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
}
