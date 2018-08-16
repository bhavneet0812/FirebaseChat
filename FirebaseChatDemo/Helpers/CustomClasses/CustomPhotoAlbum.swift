//
//  CustomPhotoAlbum.swift
//  Gospic
//
//  Created by Appinventiv on 27/09/17.
//
import Foundation
import Photos

class CustomPhotoAlbum: NSObject {
    
    static let albumName = Constants.AppTitle.localized
    static let shared = CustomPhotoAlbum()
    
    private var assetCollection: PHAssetCollection!
    
    private override init() {
        super.init()
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
    }
    
    private func checkAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.checkAuthorizationWithHandler(completion: completion)
            })
        }
        else if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    private func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    
    ///Save Image in PHOTOS
    func saveImage(imageFileUrl: URL) {
        self.checkAuthorizationWithHandler { (success) in
            if success {
                if let assetCollection = self.fetchAssetCollectionForAlbum() {
                    // Album already exists
                    self.assetCollection = assetCollection
                    PHPhotoLibrary.shared().performChanges({
                        let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: imageFileUrl)
                        let assetPlaceHolder = assetChangeRequest?.placeholderForCreatedAsset
                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                        let enumeration: NSArray = [assetPlaceHolder!]
                        albumChangeRequest!.addAssets(enumeration)
                        DispatchQueue.main.async {
                            CommonFunctions.showToastWithMessage(msg: "Image Saved in \(CustomPhotoAlbum.albumName) album", completion: nil)
                        }
                    }, completionHandler: nil)
                } else {
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
                    }) { success, error in
                        if success {
                            self.assetCollection = self.fetchAssetCollectionForAlbum()
                            PHPhotoLibrary.shared().performChanges({
                                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: imageFileUrl)
                                let assetPlaceHolder = assetChangeRequest?.placeholderForCreatedAsset
                                let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                                let enumeration: NSArray = [assetPlaceHolder!]
                                albumChangeRequest!.addAssets(enumeration)
                                DispatchQueue.main.async {
                                    CommonFunctions.showToastWithMessage(msg: "Image Saved in  \(CustomPhotoAlbum.albumName) album", completion: nil)
                                }
                            }, completionHandler: nil)
                        } else {
                            // Unable to create album
                        }
                    }
                }
            }
        }
    }
    
    ///Save Video in PHOTOS
    func saveVideo(videoFileUrl: URL) {
        self.checkAuthorizationWithHandler { (success) in
            if success {
                if let assetCollection = self.fetchAssetCollectionForAlbum() {
                    // Album already exists
                    self.assetCollection = assetCollection
                    PHPhotoLibrary.shared().performChanges({
                        let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoFileUrl)
                        let assetPlaceHolder = assetChangeRequest?.placeholderForCreatedAsset
                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                        let enumeration: NSArray = [assetPlaceHolder!]
                        albumChangeRequest!.addAssets(enumeration)
                        DispatchQueue.main.async {
                            CommonFunctions.showToastWithMessage(msg: "Video Saved in \(CustomPhotoAlbum.albumName) album", completion: nil)
                        }
                    }, completionHandler: nil)
                } else {
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
                    }) { success, error in
                        if success {
                            self.assetCollection = self.fetchAssetCollectionForAlbum()
                            PHPhotoLibrary.shared().performChanges({
                                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoFileUrl)
                                let assetPlaceHolder = assetChangeRequest?.placeholderForCreatedAsset
                                let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                                let enumeration: NSArray = [assetPlaceHolder!]
                                albumChangeRequest!.addAssets(enumeration)
                                DispatchQueue.main.async {
                                    CommonFunctions.showToastWithMessage(msg: "Video Saved in \(CustomPhotoAlbum.albumName) album", completion: nil)
                                }
                            }, completionHandler: nil)
                        } else {
                            // Unable to create album
                        }
                    }
                }
            }
        }
    }
}

