//
//  MarginTextField.swift
//  Onboarding
//
//  Created by Bhavneet Singh on 11/07/18.
//  Copyright © 2018 Gurdeep Singh. All rights reserved.
//

import UIKit

// MARK:- MARGIN LABEL
//=======================
class MarginLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let rect = CGRect(x: bounds.origin.x+10, y: bounds.origin.y,
                          width: bounds.width-20, height: bounds.height)
        super.drawText(in: rect)
    }
}

// MARK:- MARGIN TEXTFIELD
//===========================
class MarginTextField: UITextField {
    
    override func drawText(in rect: CGRect) {
        let rect = CGRect(x: bounds.origin.x+10, y: rect.origin.y,
                          width: rect.width-20, height: rect.height)
        super.drawText(in: rect)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(x: bounds.origin.x+10, y: bounds.origin.y,
                          width: bounds.width-20, height: bounds.height)
        return super.textRect(forBounds: rect)
    }
    
    override func alignmentRect(forFrame frame: CGRect) -> CGRect {
        let rect = CGRect(x: bounds.origin.x+10, y: frame.origin.y,
                          width: frame.width-20, height: frame.height)
        return super.alignmentRect(forFrame: rect)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(x: bounds.origin.x+10, y: bounds.origin.y,
                          width: bounds.width-20, height: bounds.height)
        return super.editingRect(forBounds: rect)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(x: bounds.origin.x, y: bounds.origin.y,
                          width: bounds.width, height: bounds.height)
        return super.placeholderRect(forBounds: rect)
    }
}
