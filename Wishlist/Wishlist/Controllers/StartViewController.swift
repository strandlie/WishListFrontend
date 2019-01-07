//
//  StartViewController.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 31/12/2018.
//  Copyright © 2018 Håkon Strandlie. All rights reserved.
//

import UIKit
import AWSMobileClient

class StartViewController: UIViewController {

    @IBOutlet weak var roundedLogInButton: UIButton!
    @IBOutlet weak var roundedRegisterButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    var loginViewController: LoginViewController?
    var registerViewController: SignUpViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roundedLogInButton.backgroundColor = .clear
        self.roundedLogInButton.layer.cornerRadius = 15
        self.roundedLogInButton.layer.borderWidth = 0.5
        self.roundedLogInButton.layer.borderColor = UIColor.black.cgColor
        
        self.roundedRegisterButton.backgroundColor = .clear
        self.roundedRegisterButton.layer.cornerRadius = 15
        self.roundedRegisterButton.layer.borderWidth = 0.5
        self.roundedRegisterButton.layer.borderColor = UIColor.black.cgColor
        
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
        self.loginViewController = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
       // self.registerViewController = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        
        
        self.navigationController?.pushViewController(loginViewController!, animated: true)
         */
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
