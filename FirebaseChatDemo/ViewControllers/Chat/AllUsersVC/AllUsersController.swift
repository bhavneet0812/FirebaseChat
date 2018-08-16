//
//  AllUsersController.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 15/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol AllUsersControllerDelegate: AnyObject {
    
    
}

class AllUsersController {
    
    weak var delegate: AllUsersControllerDelegate?
    
    func getUsers(allUsers: inout [UserModel]) {
        
        FireData.shared.databaseRef
            .child(CRootNode.users.rawValue)
//            .queryStarting(atValue: UserModel.main.userId)
//            .queryLimited(toFirst: 1)
            .observeSingleEvent(of: .value) { (snapshot) in
            
                
                printDebug(snapshot.value)
        }
    }
}
