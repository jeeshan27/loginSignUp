//
//  SignUpViewController.swift
//  SignUpPage
//
//  Created by Jeeshan Ali on 30/06/17.
//  Copyright © 2017 Jeeshan Ali. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.isEnabled = false
            submitButton.layer.cornerRadius = 12
        }
    }
    var areDetailsValid: Bool = false
    
    var firstName : String {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameText.delegate = self
        lastNameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        confirmPasswordText.delegate = self
    }
    
    func isEmailValid(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateData() {
        guard let firstName  = firstNameText.text,
            let lastName = lastNameText.text,
            let email = emailText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text else {
                // TODO: Show error alert
                return
        }
        areDetailsValid = true
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            areDetailsValid = false
            alert(title:"Invalid", message:"Enter All The Details")
        } else {
            if !isEmailValid(candidate: email) {
                areDetailsValid = false
                alert(title: "Invalid", message:"Enter Valid Email")
            }
            if !isPasswordValid(password) {
                areDetailsValid = false
                alert(title: "Invalid", message:"Enter Strong Password")
            }
            if password != confirmPassword {
                areDetailsValid = false
                alert(title:"Invalid", message:"Confirm Password is not Same")
            }
            
            if !areDetailsValid {
                return
            }
            
            if let check = UserDefaults.standard.value(forKey: email) {
                print(check)
                areDetailsValid = false
                alert(title:"Invalid", message:"Email Is Already Exist")
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
    
    func alert(title : String ,message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Login" {
            validateData()
            
            return areDetailsValid
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  let email = emailText.text,
            let password = passwordText.text,
            let confirmPassword = confirmPasswordText.text {
            if textField.tag == 2 && !isEmailValid(candidate: email) {
                alert(title: "Invalid", message: "Enter Valid Email Id")
            }
            if textField.tag == 3 && !isPasswordValid(password) {
                alert(title: "Invalid", message: "Enter Valid Strong Password")
            }
            if password != confirmPassword {
                alert(title: "Invalid", message: " Password And Confirm Password Are Not Equal")
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
    
}

