//
//  SignUpController.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 29/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import UIKit


@objc protocol SignUpControllerProtocol: NSObjectProtocol {
    @objc optional func signupSuccess(_ msg: String)
    @objc optional func signupFailure(_ msg: String)
    @objc optional func validationFailure(_ msg: String)
}


class SignUpController: NSObject {
    
    weak var delegate: SignUpControllerProtocol?
    
    func signup(user: UserModel, password: String, profilePic: UIImage?) {
        
        guard validate(user: user, password: password) else {
            return
        }
        
        FireAuth.shared.createUser(email: user.email, password: password, profilePic: profilePic, name: user.name, username: user.username, gender: user.gender, success: { (createdUser, info, imageUrl) in
            
            UserModel.main = user
            UserModel.main.profilePic = imageUrl
            UserModel.main.userId = ChatFunctions.convertEmailIntoFireID(email: user.email)
            UserModel.main.createdDate = Date().unixTimestamp

            self.delegate?.signupSuccess?("User has been created successfully.")
            
        }) { (error) in
            self.delegate?.signupFailure?(error?.localizedDescription ?? "User can not be created.")
        }
    }
    
    private func validate(user: UserModel, password: String) -> Bool {
        
        // Name
        if !user.name.isEmpty {
            if user.name.count < 3 {
                self.delegate?.validationFailure?("Please enter a valid name.")
                return false
            }
        } else {
            self.delegate?.validationFailure?("Please enter your name.")
            return false
        }
        
        // UserName
        if !user.username.isEmpty {
            if user.username.count < 3 {
                self.delegate?.validationFailure?("Please enter a valid username.")
                return false
            }
        } else {
            self.delegate?.validationFailure?("Please enter some username.")
            return false
        }
        
        // Email
        if !user.email.isEmpty {
            if user.email.count < 4 || user.email.checkIfInvalid(.email) {
                self.delegate?.validationFailure?("Please enter a valid email.")
                return false
            }
        } else {
            self.delegate?.validationFailure?("Please enter your email.")
            return false
        }
        
        // Phone Number
//        if !user.phoneNumber.isEmpty {
//            if user.email.count < 4 || user.email.checkIfValid(.email) {
//                self.delegate?.validationFailure?("Please enter a valid email.")
//                return false
//            }
//        } else {
//            self.delegate?.validationFailure?("Please enter your email.")
//            return false
//        }

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
