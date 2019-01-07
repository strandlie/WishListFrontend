//
//  LoginViewController.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 25/12/2018.
//  Copyright © 2018 Håkon Strandlie. All rights reserved.
//

import UIKit
import AWSMobileClient

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK: Model elements
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Hei igjen!"
        
        emailTextField.delegate = self
        
        let rightBarButton = UIBarButtonItem(title: "Ferdig", style: UIBarButtonItem.Style.done, target: self, action: #selector(LoginViewController.doneButtonTapped(_:)))
        rightBarButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButton
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.becomeFirstResponder()
    }
    
    //MARK: UIBarButton
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            email = textField.text
        }
    }


}

