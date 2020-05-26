//
//  customBorderUITextField.swift
//  Homepwner
//
//  Created by Joachim Goennheimer on 26.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import UIKit

class CustomBorderUITextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        borderStyle = .bezel
        layer.cornerRadius = 3.5
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .roundedRect
        return super.resignFirstResponder()
    }
}
