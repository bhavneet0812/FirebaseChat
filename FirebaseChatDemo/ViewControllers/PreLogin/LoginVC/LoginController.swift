//
//  LoginController.swift
//  NewProject
//
//  Created by Bhavneet Singh on 23/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation


@objc protocol LoginControllerProtocol: NSObjectProtocol {
    @objc optional func loginSuccess(_ msg: String)
    @objc optional func loginFailure(_ msg: String)
    @objc optional func validationFailure(_ msg: String)
}


class LoginController: NSObject {
    
    weak var delegate: LoginControllerProtocol?
    
    func login(email: String, password: String) {
        
        guard validate(email: email, password: password) else {
            return
        }
        
        FireAuth.shared.signInUser(email: email, password: password, success: { (createdUser, info) in
            
            self.delegate?.loginSuccess?("User has been logged in successfully.")
        }) { (error) in
            
            self.delegate?.loginFailure?(error.localizedDescription)
        }
    }
    
    private func validate(email: String, password: String) -> Bool {
        
        // Email
        if !email.isEmpty {
            if email.count < 4 || email.checkIfInvalid(.email) {
                self.delegate?.validationFailure?("Please enter a valid email.")
                return false
            }
        } else {
            self.delegate?.validationFailure?("Please enter your email.")
            return false
        }

        // Password
        if !password.isEmpty {
            if password.count < 6 {
                self.delegate?.validationFailure?("Password must have atleast 6 characters.")
                return false
            }
        } else {
            self.delegate?.validationFailure?("Please enter some Password.")
            return false
        }
        
        return true
    }
}
