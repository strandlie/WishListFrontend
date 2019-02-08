//
//  PersonDetailViewController.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 12/01/2019.
//  Copyright © 2019 Håkon Strandlie. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    let notValidEmailText: String = "Ikke en gyldig epostadresse"
    let notValidPasswordText: String = "Passord må ha minst 8 tegn, en stor og en liten bokstav og ett tall. Prøv et annet passord."
    let notValidFirstNameText = "Du må skrive inn et fornavn"
    let notValidLastNameText = "Du må skrive inn et etternavn"
    
    let emailAddressAlreadyExists: String = "Det finnes allerede en bruker registrert med denne epostadressen. Hvis du ikke husker passordet kan du tilbakestille"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: TextFieldValidation
    
    func emailIsReadyForValidation(_ text: String) -> Bool {
        if text.contains(".") && text.contains("@") && text.count > 6 {
            return true
        }
        return false
    }
    
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func isValidPassword(_ testStr:String) -> Bool {
        /*
         ^                                                          -Start Anchor.
         (?=.*[a-z])                                                -Ensure string has at least one lowercase letter
         (?=.*[A-Z])                                                -Ensure string has at least one uppercase letter.
         (?=.*[0-9])                                                -Ensure string has at least one digit.
         [a-zA-Z0-9]                                                -Ensure rest of string are only letters and numbers
         {8,}                                                       -Ensure password length is 8.
         $                                                          -End Anchor.
         */
        
        //let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: testStr)
    }
    
    func isValidName(_ testStr:String) -> Bool {
        return testStr.count > 0
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
