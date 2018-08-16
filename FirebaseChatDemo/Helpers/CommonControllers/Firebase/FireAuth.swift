//
//  FireAuth.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 09/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import Foundation
import FirebaseAuth


class FireAuth {
    
    static var shared = FireAuth()
    private init() { }

    var defaultAuth = Auth.auth()
    
    var currentUser: User? {
        return defaultAuth.currentUser
    }
}


extension FireAuth {
    
    /// Create New User
    func createUser(email: String,
                    password: String,
                    profilePic: UIImage? = nil,
                    name: String,
                    username: String,
                    gender: String,
                    loader: Bool = true,
                    success: @escaping ((_ user: User, _ additionalInfo: AdditionalUserInfo?, _ imageUrl: String?) -> Void),
                    failure: @escaping ((_ error: Error?) -> Void)) {
        
        if loader { CommonFunctions.showActivityLoader() }

        defaultAuth.createUser(withEmail: email, password: password) { (result, error) in
            
            guard let unwrappedResult = result else {

                if loader { CommonFunctions.hideActivityLoader() }

                failure(error)
                return
            }
            
            let changeRequest = self.currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name

            if let image = profilePic {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    FireStorage.shared.uploadData(data: imageData, folder: "profile_pics", fileName: name, mimeType: MimeType.mimeValue(for: "jpg") ?? "image/jpg", success: { (snapshot) in
                        
                        snapshot.reference.downloadURL(completion: { (url, error) in
                            
                            if loader { CommonFunctions.hideActivityLoader() }

                            changeRequest?.photoURL = url
                            changeRequest?.commitChanges(completion: nil)

                            success(unwrappedResult.user, unwrappedResult.additionalUserInfo, url?.absoluteString)
                        })
                        
                    }, error: { (error) in
                        
                        if loader { CommonFunctions.hideActivityLoader() }

                        changeRequest?.commitChanges(completion: nil)
                        success(unwrappedResult.user, unwrappedResult.additionalUserInfo, nil)
                    })
                } else {

                    if loader { CommonFunctions.hideActivityLoader() }

                    success(unwrappedResult.user, unwrappedResult.additionalUserInfo, nil)
                }
            } else {

                if loader { CommonFunctions.hideActivityLoader() }

                success(unwrappedResult.user, unwrappedResult.additionalUserInfo, nil)
            }
        }
    }
    
    /// Sign In User to Firebase
    func signInUser(email: String,
                    password: String,
                    loader: Bool = true,
                    success: @escaping ((_ user: User,_ additionalInfo: AdditionalUserInfo?) -> Void),
                    failure: @escaping ((_ error: NSError) -> Void)) {
        
        if loader { CommonFunctions.showActivityLoader() }

        defaultAuth.signIn(withEmail: email, password: password) { (result, error) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if let unwrappedError = error as NSError? {
                failure(unwrappedError)
            } else if let unwrappedResult = result {
                success(unwrappedResult.user, unwrappedResult.additionalUserInfo)
            } else {
                failure(NSError(localizedDescription: "No Result Found"))
            }
        }
    }
    
    /// Forgot Password
    func forgotPassword(email: String,
                        loader: Bool = true,
                        completion: ((Error) -> Void)? = nil) {
        
        if loader { CommonFunctions.showActivityLoader() }

        defaultAuth.sendPasswordReset(withEmail: email) { (error) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if let unwrappedError = error {
                completion?(unwrappedError)
            }
        }
    }
    
    /// Reset Password
    func resetPassword(resetCode: String,
                       newPassword: String,
                       loader: Bool = true,
                       completion: ((Error) -> Void)? = nil) {
        
        if loader { CommonFunctions.showActivityLoader() }

        defaultAuth.confirmPasswordReset(withCode: resetCode, newPassword: newPassword) { (error) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if let unwrappedError = error {
                completion?(unwrappedError)
            }
        }
    }
    
    /// Verify Reset Code
    func verifyResetCode(resetCode: String,
                         loader: Bool = true,
                         completion: ((_ result: String?, _ error: Error?) -> Void)? = nil) {
        
        if loader { CommonFunctions.showActivityLoader() }

        defaultAuth.verifyPasswordResetCode(resetCode, completion: { (result, error) in

            if loader { CommonFunctions.hideActivityLoader() }

            completion?(result, error)
        })
    }
    
    /// Update User
    func updateUser(user: User,
                    loader: Bool = true,
                    completion: ((Error) -> Void)? = nil) {
        
        if loader { CommonFunctions.showActivityLoader() }
        
        defaultAuth.updateCurrentUser(user) { (error) in
            
            if loader { CommonFunctions.hideActivityLoader() }
            
            if let unwrappedError = error {
                completion?(unwrappedError)
            }
        }
    }
    
    /// Logout User
    func logoutUser(success: @escaping (() -> Void),
                    failure: @escaping ((_ error: NSError) -> Void)) {
        
        do {
            try defaultAuth.signOut()
            success()
        } catch {
            failure(error as NSError)
        }
    }
}
