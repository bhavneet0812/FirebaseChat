//
//  AppNetworking.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Photos

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (NSError) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
typealias DownloadData = (_ data : Data) -> ()
typealias UploadFileParameter = [(fileName: String, key: String, data: Data, mimeType: String)]

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
    static func POST(endPoint : String,
                     parameters : JSONDictionary = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (NSError) -> Void) {
        
        
        request(URLString: endPoint, httpMethod: .post, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func POSTWithFiles(endPoint : String,
                              parameters : [String : Any] = [:],
                              files : UploadFileParameter = [],
                              headers : HTTPHeaders = [:],
                              loader : Bool = true,
                              success : @escaping (JSON) -> Void,
                              failure : @escaping (NSError) -> Void) {
        
        upload(URLString: endPoint, httpMethod: .post, parameters: parameters, files: files, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func GET(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    willStoreLocally: Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (NSError) -> Void) {
        
        request(URLString: endPoint, httpMethod: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers, loader: loader, willStoreLocally: willStoreLocally, success: success, failure: failure)
    }
    
    static func PUT(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (NSError) -> Void) {
        
        request(URLString: endPoint, httpMethod: .put, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func PATCH(endPoint : String,
                      parameters : JSONDictionary = [:],
                      encoding: URLEncoding = URLEncoding.httpBody,
                      headers : HTTPHeaders = [:],
                      loader : Bool = true,
                      success : @escaping SuccessResponse,
                      failure : @escaping FailureResponse) {
        
        request(URLString: endPoint, httpMethod: .patch, parameters: parameters, encoding: encoding, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func DELETE(endPoint : String,
                       parameters : JSONDictionary = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       success : @escaping (JSON) -> Void,
                       failure : @escaping (NSError) -> Void) {
        
        request(URLString: endPoint, httpMethod: .delete, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func DOWNLOAD(endPoint : String,
                         parameters : JSONDictionary = [:],
                         headers : HTTPHeaders = [:],
                         mediaType : String,
                         loader : Bool = true,
                         success : @escaping (Bool) -> Void,
                         failure : @escaping (NSError) -> Void) {
        
        download(URLString: endPoint, httpMethod: .get, parameters: parameters, headers: headers, mediaType: mediaType, loader: loader, success: success, failure: failure)
    }
    
    private static func download(URLString : String,
                                 httpMethod : HTTPMethod,
                                 parameters : JSONDictionary = [:],
                                 encoding: URLEncoding = URLEncoding.default,
                                 headers : HTTPHeaders = [:],
                                 mediaType : String,
                                 loader : Bool = true,
                                 success : @escaping (Bool) -> Void,
                                 failure : @escaping (NSError) -> Void) {
        
        
        var fileURL = URL(string: "")
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _  in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            fileURL = documentsURL.appendingPathComponent(mediaType.replace(string: "/", withString: "."))
            return (fileURL!, [.removePreviousFile, .createIntermediateDirectories])
            
        }
        
        if loader { CommonFunctions.showActivityLoader() }

        Alamofire.download(URLString, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers, to: destination).response { (response) in
            
            if loader { CommonFunctions.hideActivityLoader() }

            if response.error != nil {
                printDebug("===================== FAILURE =======================")
                let e = response.error!
                printDebug(e.localizedDescription)
                
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                }
                failure(e as NSError)
                
            } else {
                printDebug("===================== RESPONSE =======================")
                guard response.error == nil else { return }
                
                switch mediaType {
                    
                case "video/mp4":  CustomPhotoAlbum.shared.saveVideo(videoFileUrl: fileURL!)
                    
                case "application/pdf":
                    break
                    //insantiate webViewVC
                    //webView.loadRequest(URLRequest(url: fileURL!))
                    
                default: CustomPhotoAlbum.shared.saveImage(imageFileUrl: fileURL!)
                    
                }
                success(true)
            }
        }
    }
    
    private static func request(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                encoding: URLEncoding = URLEncoding.httpBody,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                willStoreLocally: Bool = false,
                                success : @escaping (JSON) -> Void,
                                failure : @escaping (NSError) -> Void) {
        
        if loader { CommonFunctions.showActivityLoader() }
        
        Alamofire.request(URLString, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            if loader { CommonFunctions.hideActivityLoader() }
            
            printDebug("===================== METHOD =========================")
            printDebug(httpMethod)
            printDebug("===================== ENCODING =======================")
            printDebug(encoding)
            printDebug("===================== URL STRING =====================")
            printDebug(URLString)
            printDebug("===================== HEADERS ========================")
            printDebug(headers)
            printDebug("===================== PARAMETERS =====================")
            printDebug(parameters.description)
            
            switch(response.result) {
            case .success(let value):
                printDebug("===================== RESPONSE =======================")
                printDebug(JSON(value))
                
                let json = JSON(value)
                success(json)
                
            case .failure(let e):
                printDebug("===================== FAILURE =======================")
                printDebug(e.localizedDescription)
                
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                    
                    CommonFunctions.showToastWithMessage(msg: Constants.NoInternetConnection.localized, completion: nil)
                    failure(e as NSError)

                } else {
                    failure(e as NSError)
                }
            }
        }
    }
    
    
    private static func upload(URLString : String,
                               httpMethod : HTTPMethod,
                               parameters : JSONDictionary = [:],
                               files : UploadFileParameter = [],
                               headers : HTTPHeaders = [:],
                               loader : Bool = true,
                               success : @escaping (JSON) -> Void,
                               failure : @escaping (NSError) -> Void) {
        
        guard let url = try? URLRequest(url: URLString, method: httpMethod, headers: headers) else { return }

        if loader { CommonFunctions.showActivityLoader() }

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            files.forEach({ (fileParamObject) in
                
                multipartFormData.append(fileParamObject.data, withName: fileParamObject.key, fileName: fileParamObject.fileName, mimeType: fileParamObject.mimeType)
            })
            
            parameters.forEach({ (paramObject) in
                
                multipartFormData.append((paramObject.value as AnyObject).data(using : String.Encoding.utf8.rawValue)!, withName: paramObject.key)
            })

        }, with: url, encodingCompletion: { encodingResult in
            
            switch encodingResult{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    
                    if loader { CommonFunctions.hideActivityLoader() }

                    printDebug("===================== METHOD =========================")
                    printDebug(httpMethod)
                    printDebug("===================== URL STRING =====================")
                    printDebug(URLString)
                    printDebug("===================== HEADERS ========================")
                    printDebug(headers)
                    printDebug("===================== PARAMETERS =====================")
                    printDebug(parameters)
                    
                    switch response.result{
                    case .success(let value):
                        printDebug("===================== RESPONSE =======================")
                        printDebug(JSON(value))
                        
                        success(JSON(value))
                    case .failure(let e):
                        printDebug("===================== FAILURE =======================")
                        printDebug(e.localizedDescription)
                        
                        if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                            NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                        }
                        failure(e as NSError)
                    }
                })
                
            case .failure(let e):
                
                if loader { CommonFunctions.hideActivityLoader() }

                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                }
                failure(e as NSError)
            }
        })
    }
}
