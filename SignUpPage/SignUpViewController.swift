//
//  SignUpViewController.swift
//  SignUpPage
//
//  Created by Jeeshan Ali on 30/06/17.
//  Copyright © 2017 Jeeshan Ali. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameText: UITextField! {
        didSet{
            firstNameText.delegate = self
        }
    }
    @IBOutlet weak var lastNameText: UITextField! {
        didSet{
            lastNameText.delegate = self
        }
    }
    @IBOutlet weak var emailText: UITextField! {
        didSet{
            emailText.delegate = self
        }
    }
    @IBOutlet weak var passwordText: UITextField! {
        didSet{
            passwordText.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordText: UITextField! {
        didSet{
            confirmPasswordText.delegate = self
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.isEnabled = false
            submitButton.layer.cornerRadius = 12
        }
    }
    var areDetailsValid: Bool = false
    
    var firstName : String {
        return firstNameText.text ?? ""
    }
    var lastName : String {
        return lastNameText.text ?? ""
    }
    var email : String {
        return emailText.text ?? ""
    }
    var password : String {
        return passwordText.text ?? ""
    }
    var confirmPassword : String {
        return confirmPasswordText.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func validateData() {
        areDetailsValid = true
        
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            areDetailsValid = false
            alert(message: Messages.empty.rawValue)
        } else {
            if !isEmailValid(candidate: email) {
                areDetailsValid = false
                alert(message: Messages.isValidEmail.rawValue)
            }
            if !isPasswordValid(password) {
                areDetailsValid = false
                alert(message: Messages.isValidPassword.rawValue)
            }
            if password != confirmPassword {
                areDetailsValid = false
                alert(message: Messages.confirmPassword.rawValue)
            }
            
            if !areDetailsValid {
                return
            }
            
            if let check = UserDefaults.standard.value(forKey: email) {
                print(check)
                areDetailsValid = false
                alert(message: Messages.alreadyExist.rawValue)
            } else {
                let user = [
                    UserDefaultKeys.firstName: firstName ,
                    UserDefaultKeys.lastName: lastName,
                    UserDefaultKeys.email: email,
                    UserDefaultKeys.password: password
                ]
                UserDefaults.standard.set(user, forKey: email)
                // performSegue(withIdentifier: "Login", sender: self)
            }
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Login" {
            validateData()
            
            return areDetailsValid
        }
        
        return true
    }
}

extension SignUpViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  let email = emailText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            if textField.tag == 2 && !isEmailValid(candidate: email) {
                alert(message: Messages.isValidEmail.rawValue)
            }
            if textField.tag == 3 && !isPasswordValid(password) {
                alert(message: Messages.isValidPassword.rawValue)
            }
            if password != confirmPassword {
                alert(message: Messages.confirmPassword.rawValue)
            }
        }
        else {
            alert(title: "Invalid", message: "Enter All The Details")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let firstName  = firstNameText.text,
            let lastName = lastNameText.text,
            let email = emailText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = true
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

