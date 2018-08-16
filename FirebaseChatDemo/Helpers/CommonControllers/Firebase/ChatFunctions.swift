//
//  ChatFunctions.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 16/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation

enum ChatFunctions {
    
    /// Convert Email into FireBase ID
    static func convertEmailIntoFireID(email: String) -> String {
        
        let encodedEmail = email.base64Encoded
        return encodedEmail
    }
    
}
