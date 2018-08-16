//
//  UserInputKeys.swift
//  DittoFashionMarketBeta
//
//  Created by Appinventiv Technologies on 05/02/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation

//MARK:- Api Keys
//=======================
enum ApiKey {
    
    static var status: String                   { return "status" }
    static var userId: String                   { return "userId" }
    static var profilePic: String               { return "profilePic" }
    static var name: String                     { return "name" }
    static var username: String                 { return "username" }
    static var email: String                    { return "email" }
    static var phoneNumber: String              { return "phoneNumber" }
    static var password: String                 { return "password" }
    static var gender: String                   { return "gender" }
    static var createdDate: String              { return "createdDate" }

}

//MARK:- Api Code
//=======================
enum ApiCode {
    
    static var success: Int                             { return 200 } // Success

}
