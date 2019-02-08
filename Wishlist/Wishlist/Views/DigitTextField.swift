//
//  DigitTextField.swift
//  Wishlist
//
//  Created by Håkon Strandlie on 03/02/2019.
//  Copyright © 2019 Håkon Strandlie. All rights reserved.
//

import UIKit

class DigitTextField: UITextField {

    open var previousTextField: DigitTextField?
    open var nextTextField: DigitTextField?
    
    
    override func deleteBackward() {
        super.deleteBackward()
        
        
        if self.tag > 0 {
            // Do nothing for the first textField
            
            self.previousTextField?.text = ""
            tellDelegateToDeleteCodeAt(self.tag - 1)
            resignFirstResponder()
            selectNextFirstResponder(isMovingForward: false)
        }
       
    }
    
    func clear() {
        self.text = "-"
        tellDelegateToDeleteCodeAt(self.tag)
    }
    
    open func selectNextFirstResponder(isMovingForward forward: Bool) {
        if forward {
            if let nextTextField = nextTextField {
                nextTextField.becomeFirstResponder()
            }
        } else {
            if let previousTextField = previousTextField {
                previousTextField.becomeFirstResponder()
            }
        }
    }
    
    private func tellDelegateToDeleteCodeAt(_ position: Int) {
        guard let digitDelegate = (delegate as! DigitTextFieldDelegate?) else {
            fatalError("Delegate is of unexpected type")
        }
        digitDelegate.deleteCodeEntryFor(position)
    }
    
}

protocol DigitTextFieldDelegate: UITextFieldDelegate {
    func deleteCodeEntryFor(_ position: Int)
}
