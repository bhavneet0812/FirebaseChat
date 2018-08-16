//
//  CommonClasses.swift
//  DittoFashionMarketBeta
//
//  Created by Bhavneet Singh on 23/11/17.
//  Copyright © 2017 Bhavneet Singh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SKToast
import NVActivityIndicatorView
//import SlideMenuControllerSwift
import MobileCoreServices

class CommonFunctions {

    static func showToastWithMessage(msg: String, completion: (() -> Swift.Void)? = nil) {

        DispatchQueue.mainQueueAsync {
            
            SKToast.backgroundStyle(UIBlurEffectStyle.dark)
            SKToast.messageFont(AppFonts.Montserrat_Regular.withSize(14))
            SKToast.messageTextColor(AppColors.white)
            SKToast.show(withMessage: msg, completionHandler: {
                completion?()
            })
        }
    }
    
    class func delay(delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            closure()
            
        }
    }
    
    class func showActionSheetWithActionArray(_ title: String?, message: String?,
                                              viewController: UIViewController,
                                              alertActionArray : [UIAlertAction],
                                              preferredStyle: UIAlertControllerStyle)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActionArray.forEach{ alert.addAction($0) }
        
        DispatchQueue.mainQueueAsync {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    class func showActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.startNYLoader()
            }
        }
    }
    
    class func hideActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.stopAnimating()
            }
        }
    }
}
