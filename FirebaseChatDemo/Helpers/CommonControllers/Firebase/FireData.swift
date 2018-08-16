//
//  FireData.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 16/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseDatabase

class FireData {
    
    static var shared = FireData()
    private init() { }
    
    // Get a reference to the database service using the default Firebase App
    let database = Database.database()
    
    // Create a database reference from our database service
    var databaseRef: DatabaseReference {
        return database.reference().root
    }
}


extension FireData {
    
    /// Get Data
    func getData(path: String,
                 loader: Bool = true,
                 success: @escaping ((_ json: JSON) -> Void),
                 failure: @escaping ((_ error: NSError) -> Void)) {
        
        if loader { CommonFunctions.showActivityLoader() }

        databaseRef.child(path).observeSingleEvent(of: .value) { (snapshot) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if let value = snapshot.value {
                success(JSON(value))
            } else {
                failure(NSError(localizedDescription: "\(path)\nData not found"))
            }
        }
    }

    /// Set Observer
    func setObserver(path: String,
                     event: DataEventType,
                     success: @escaping ((_ json: JSON) -> Void),
                     failure: @escaping ((_ error: NSError) -> Void)) {
        
        databaseRef.child(path).observe(event) { (snapshot) in
            
            if let value = snapshot.value {
                success(JSON(value))
            } else {
                failure(NSError(localizedDescription: "\(path)\nData not found"))
            }
        }
    }

    /// Add Child
    func addChild(path: String,
                  data: JSONDictionary,
                  loader: Bool = true,
                  success: @escaping (() -> Void),
                  failure: @escaping ((_ error: NSError) -> Void)) {
        
        if loader { CommonFunctions.showActivityLoader() }

        databaseRef.child(path).setValue(data) { (error, reference) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if let unwrappedError = error as NSError? {
                failure(unwrappedError)
            } else {
                success()
            }
        }
    }
}
