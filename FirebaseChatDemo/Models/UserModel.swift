//
//  UserModel.swift
//  FartrBeta
//
//  Created by Bhavneet Singh on 28/05/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import SwiftyJSON


struct UserModel {

    static var main = UserModel(AppUserDefaults.value(forKey: .fullUserProfile)) {
        didSet {
            _ = main.saveToUserDefaults()
        }
    }

    var userId: String
    var profilePic: String?
    var name: String
    var username: String
    var email: String
    var phoneNumber: String
    var gender: String
    var status: String
    var createdDate: Double

    init(_ json: JSON = JSON()) {
        
        self.userId = json[ApiKey.userId].stringValue
        self.profilePic = json[ApiKey.profilePic].stringValue
        self.name = json[ApiKey.name].stringValue
        self.username = json[ApiKey.username].stringValue
        self.email = json[ApiKey.email].stringValue
        self.phoneNumber = json[ApiKey.phoneNumber].stringValue
        self.gender = json[ApiKey.gender].stringValue
        self.status = json[ApiKey.status].stringValue
        self.createdDate = json[ApiKey.createdDate].doubleValue
    }


    func saveToUserDefaults() -> JSONDictionary {
        
        var dict: JSONDictionary = [:]
        
        dict[ApiKey.userId] = self.userId
        dict[ApiKey.profilePic] = self.profilePic
        dict[ApiKey.name] = self.name
        dict[ApiKey.username] = self.username
        dict[ApiKey.email] = self.email
        dict[ApiKey.phoneNumber] = self.phoneNumber
        dict[ApiKey.gender] = self.gender
        dict[ApiKey.status] = self.status
        dict[ApiKey.createdDate] = self.createdDate

        AppUserDefaults.save(value: dict, forKey: .fullUserProfile)
        
        return dict
    }
}
