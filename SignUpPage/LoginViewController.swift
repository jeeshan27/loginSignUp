//
//  LoginViewController.swift
//  SignUpPage
//
//  Created by Jeeshan Ali on 30/06/17.
//  Copyright © 2017 Jeeshan Ali. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
            loginButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var loginUserName: UITextField! {
        didSet{
            loginUserName.delegate = self
        }
    }
    @IBOutlet weak var loginPasswordText: UITextField! {
        didSet{
            loginPasswordText.delegate = self
        }
    }
    var areValidDetails : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
       guard let username = loginUserName.text,
             let password = loginPasswordText.text else{return}
        
        if username.isEmpty  {
            areValidDetails = false
            alert(title:"Invalid", message:"Enter Username")
        }
        if password.isEmpty {
            areValidDetails = false
            alert(title: "Invalid", message:"Enter Password")
        } else if let data = UserDefaults.standard.object(forKey: username ) as? [String : String] {
            if loginUserName.text == data[UserDefaultKeys.email] && loginPasswordText.text == data[UserDefaultKeys.password] {
                let userDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                userDetailsViewController.email = data[UserDefaultKeys.email]
                self.navigationController?.pushViewController(userDetailsViewController, animated: true)
            } else {
                areValidDetails = false
                alert(title: "Inavlid", message: "Eneter ")
            }
        }
    }
    
    func alert(title : String ,message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return areValidDetails
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let userName = loginUserName.text,
              let password = loginPasswordText.text else { return }
             
    }
}
