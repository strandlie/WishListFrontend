//
//  SixDigitInputViewController.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 24/01/2019.
//  Copyright © 2019 Håkon Strandlie. All rights reserved.
//

import UIKit
import AWSMobileClient

class SixDigitInputViewController: UIViewController, DigitTextFieldDelegate {
   
    // MARK: Properties
    var nextTag: Int = 0
    var emailToConfirm: String!
    var spinner: SpinnerViewController?
    
    var textFields  = [Int: DigitTextField]()
    var code  = [Int]()
    
    
    @IBOutlet weak var digit0TextField: DigitTextField!
    @IBOutlet weak var digit1TextField: DigitTextField!
    @IBOutlet weak var digit2TextField: DigitTextField!
    @IBOutlet weak var digit3TextField: DigitTextField!
    @IBOutlet weak var digit4TextField: DigitTextField!
    @IBOutlet weak var digit5TextField: DigitTextField!
    
    
    public init(emailToConfirm email: String) {
        super.init(nibName: nil, bundle: nil)
        self.emailToConfirm = email
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        textFields[0] = digit0TextField
        textFields[1] = digit1TextField
        textFields[2] = digit2TextField
        textFields[3] = digit3TextField
        textFields[4] = digit4TextField
        textFields[5] = digit5TextField
        
        // Create tags and cross references for digits
        for (id, textField) in textFields {
            textField.delegate = self
            textField.tag = id
            if id != 0 && id != 5 {
                textFields[id]?.previousTextField = textFields[id - 1]
                textFields[id]?.nextTextField = textFields[id + 1]
            } else if id == 0 {
                textField.nextTextField = textFields[id + 1]
            } else if id == 5 {
                textField.previousTextField = textFields[id - 1]
            }
        }
        
        digit0TextField.becomeFirstResponder()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    /*
     Only change first responder status when not at the ends
 
    Currently not needed. Keeping around, in case current implementation
    is inadequate.
 
    func decideNextResponder(isGoingForward forward: Bool) {
        if forward && nextTag < 5 {
            textFields[nextTag + 1]?.becomeFirstResponder()
        } else if !forward && nextTag > 0 {
            textFields[nextTag - 1]?.becomeFirstResponder()
        }
    }
    */
    
    func createSpinnerView() {
        self.spinner = SpinnerViewController()
        
        // add the spinner view controller
        addChild(self.spinner!)
        self.spinner!.view.frame = view.frame
        view.addSubview(self.spinner!.view)
        self.spinner!.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        guard let spinner = self.spinner else {
            fatalError("Spinner has been replaced by nil.")
        }
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    
    func registrationDidSucceed() {
        print("Properly registered")
    }
    
    // MARK: - UITextFieldDelegate
  
    @IBAction func textFieldChanged(_ sender: DigitTextField, forEvent event: UIEvent) {
        guard let intValue = Int(sender.text ?? "") else {
            fatalError("The user entered something other than an integer, or invalid character. Entered character was \(sender.text ?? "nil")")
        }
        code.append(intValue)
        sender.resignFirstResponder()
        sender.selectNextFirstResponder(isMovingForward: true)
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == digit5TextField {
            var codeArray = code.map { String($0) }
            AWSMobileClient.sharedInstance().confirmSignUp(username: emailToConfirm, confirmationCode: codeArray.joined()) { (signUpResult, error) in
                
                if let signUpResult = signUpResult {
                    // Consider using a common routine in RegisterViewController to check state, to be able to try again several times.
                    }
                
                else if let error = error {
                    if let error  = error as? AWSMobileClientError {
                        switch(error) {
                            // Handle error
                        default:
                            fatalError("Not implemented")
                        }
                        
                    }
                    
                    
                }
                
            }
        }
    }
    
    open func deleteCodeEntryFor(_ position: Int) {
        code.remove(at: position)
    }
    
    func clear() {
        for index in 5...0 {
            textFields[index]?.clear()
        }
        code = [Int]()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
