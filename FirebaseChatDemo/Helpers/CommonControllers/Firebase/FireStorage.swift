//
//  FireStorage.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 30/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import FirebaseStorage

class FireStorage {
    
    static var shared = FireStorage()
    private init() { }

    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    
    // Create a storage reference from our storage service
    var storageRef: StorageReference {
        return storage.reference().root()
    }
}


extension FireStorage {
    
    func uploadData(data: Data,
                    folder: String = "Others",
                    fileName: String? = nil,
                    mimeType: String,
                    loader: Bool = true,
                    progress: ((_ progress: Progress) -> Void)? = nil,
                    success: @escaping ((_ snapshot: StorageTaskSnapshot) -> Void),
                    error: @escaping ((_ error: Error) -> Void)) {
        
        if loader { CommonFunctions.showActivityLoader() }
        
        let rootFolderName = mimeType.components(separatedBy: "/").first ?? "Others"
        
        var name = rootFolderName
        if let fName = fileName {
            name = fName
        }
        name.append("\(Date.timeIntervalSinceReferenceDate.bitPattern)")
        
        let type = MimeType.extValue(for: mimeType) ?? "data"
        
        let uploadDataRef = storageRef.child("\(rootFolderName)/\(folder)/\(name).\(type)")
        
        let storageMetaData = StorageMetadata()
        storageMetaData.contentType = type
        storageMetaData.cacheControl = "no-store"
        storageMetaData.customMetadata = [:]
        
        let uploadTask = uploadDataRef.putData(data, metadata: storageMetaData)
        
        uploadTask.observe(.progress) { (snapshot) in
            if let unwrappedProgress = snapshot.progress {
                progress?(unwrappedProgress)
            }
        }
        
        uploadTask.observe(.failure) { (snapshot) in

            if loader { CommonFunctions.hideActivityLoader() }

            if let unwrappedError = snapshot.error {
                error(unwrappedError)
            }
        }
        
        uploadTask.observe(.success) { (snapshot) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            success(snapshot)
        }
    }
    
}
