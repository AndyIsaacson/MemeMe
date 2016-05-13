//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Andy Isaacson on 5/3/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import Foundation
import UIKit

class MemeTextField: UITextField, UITextFieldDelegate {
    
    var defaultText = "MEME TEXT"
    var _modified = false
    var modified:Bool {
        set {
            _modified = newValue
            for block in modifiedNotifierBlocks {
                block()
            }
        }
        
        get {
            return _modified
        }
    }
    
    var modifiedNotifierBlocks: [() -> ()] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        initializeAttributes()
    }
    
    func reset() {
        self.text = defaultText
        self.modified = false
    }
    
    func initializeAttributes() {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -1.0
        ]
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = NSTextAlignment.Center
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // If this is our first insertion, clear the placeholder
        if !self.modified {
            textField.text = string
            self.modified = true
            return false
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // Clear the placeholder if we haven't changed it
        if !self.modified {
            textField.text = ""
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        // Reset the placeholder if we haven't changed it
        if !self.modified {
            reset()
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}