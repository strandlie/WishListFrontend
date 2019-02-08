//
//  RegisterViewController.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 31/12/2018.
//  Copyright © 2018 Håkon Strandlie. All rights reserved.
//

import UIKit
import AWSMobileClient

class RegisterViewController: PersonDetailViewController, UITextFieldDelegate {
    
    
    

    //MARK: Properties
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    
    //MARK: Model elements
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    
    var existingEmailAdresses: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Title options
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Litt om deg"
        
        // NavigationBar options
        let rightBarButton = UIBarButtonItem(title: "Registrer", style: UIBarButtonItem.Style.plain, target: self, action: #selector(RegisterViewController.registerButtonTapped(_:)))
        rightBarButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        // FirstNameTextField options
        firstNameTextField.delegate = self
        firstNameLabel.isHidden = true
        firstNameLabel.text = notValidFirstNameText
        
        // LastNameTextField options
        lastNameTextField.delegate = self
        lastNameLabel.isHidden = true
        lastNameLabel.text = notValidLastNameText
        
        // EmailTextField options
        emailTextField.delegate = self
        emailLabel.isHidden = true
        emailLabel.text = notValidEmailText
        
        // PasswordTextField options
        passwordTextField.delegate = self
        passwordLabel.isHidden = true
        passwordLabel.text = notValidPasswordText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firstNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    //MARK: UIBarButton
    @objc func registerButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            fatalError("One of the nameTextFields want to return with text attribute nil. Should never happen.")
        }
        if textField == firstNameTextField {
            if isValidName(text) {
                firstNameLabel.isHidden = true
                textField.resignFirstResponder()
                return true
            }
            firstNameLabel.isHidden = false
            return false
    
        } else if textField == lastNameTextField {
            if isValidName(text) {
                lastNameLabel.isHidden = true
                textField.resignFirstResponder()
                return true
            }
            lastNameLabel.isHidden = false
            return false
            
        } else if textField == passwordTextField {
            if isValidPassword(text) {
                passwordLabel.isHidden = true
                textField.resignFirstResponder()
                return true
            }
            passwordLabel.isHidden = false
            return false
            
        } else if textField == emailTextField {
            if isValidEmail(text) {
                emailLabel.isHidden = true
                textField.resignFirstResponder()
                return true
            }
            emailLabel.text = notValidEmailText
            emailLabel.isHidden = false
            return false
        } else {
            fatalError("Unknown textField wants to return")
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            fatalError("TextField wants to return with nil as text attribute")
        }
        if textField == firstNameTextField {
            firstName = text
            firstNameLabel.isHidden = isValidName(text)
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            lastName = text
            lastNameLabel.isHidden = isValidName(text)
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            email = text
            if emailIsReadyForValidation(text) {
                emailLabel.isHidden = isValidEmail(text)
            }
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            password = text
            passwordLabel.isHidden = isValidPassword(text)
        } else {
            fatalError("Unknown textField did end editing")
        }
        
        if isValidName(firstName ?? "") && isValidName(lastName ?? "") && isValidEmail(email ?? "") && isValidPassword(password ?? "") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            makeRegisterCallToServer()
        }
    }
    
    //MARK: TextField validation
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        if sender == firstNameTextField {
            firstNameLabel.isHidden = isValidName(text)
        } else if sender == lastNameTextField {
            lastNameLabel.isHidden = isValidName(text)
        } else if sender == emailTextField {
            if emailIsReadyForValidation(text) {
                emailLabel.isHidden = isValidEmail(text)
            }
        } else if sender == passwordTextField {
            passwordLabel.isHidden = isValidPassword(text)
        } else {
            fatalError("Sending TextField was not firstNmae, lastName, email og password.")
        }
    }
    
    override func isValidEmail(_ testStr: String) -> Bool {
        return super.isValidEmail(testStr) && !existingEmailAdresses.contains(testStr)
    }
 

    //MARK: Register
    func makeRegisterCallToServer() {
        // Force unwraps optionals, because this method is never called unless those are valid
        AWSMobileClient.sharedInstance().signUp(username: email!, password: password!, userAttributes: ["given_name":firstName!, "family_name":lastName!, "email": email!]) { (signUpResult, error) in
            
            if let signUpResult = signUpResult {
                switch(signUpResult.signUpConfirmationState) {
                case .confirmed:
                    print("User is signed up and confirmed")
                case .unconfirmed:
                    print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                    
                    self.switchToViewController(identifier: "SixDigitInputViewController")
                    
                case .unknown:
                    print("Unexpected case")
                }
            } else if let error = error {
                if let error  = error as? AWSMobileClientError {
                    switch(error) {
                    case .usernameExists(let message):
                        print(message)
                        self.existingEmailAdresses.append(self.email!)
                        self.emailLabel.numberOfLines = 3
                        self.emailLabel.text = self.emailAddressAlreadyExists
                        self.emailLabel.isHidden = false
                    default:
                        print(error)
                        fatalError("Uncaught error in signUp process")
                        
                    }
                    
                }
                
            
            }
            
        }
    }
    
    func switchToViewController(identifier: String) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) else {
            fatalError("\(identifier) is not a valid Storyboard ViewController")
        }
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    

    // MARK: - Navigation
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is StartViewController {
            segue.destination.navigationController?.navigationBar.prefersLargeTitles = false
        }
       
    }
    */

}
