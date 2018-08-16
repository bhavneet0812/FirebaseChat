//
//  AppDelegate.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 28/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import Fabric
import Crashlytics
import IQKeyboardManagerSwift
import SwiftyJSON

public enum AppLanguage: String {
    case english = "en"
    case portugueseBrazil = "pt-BR"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    
    var window: UIWindow?
    var nvc: UINavigationController?
    var appLanguage: AppLanguage = .english
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true

        DispatchQueue.mainQueueAsync {
            
            IQKeyboardManager.shared.enableAutoToolbar = false
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        }
        
//        AppRouter.goToChatUsersScreen()

        self.goToFirstScreen()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


extension AppDelegate {
    
    /// Setup First screen
    private func goToFirstScreen() {
        
        if AppUserDefaults.value(forKey: .fullUserProfile) == JSON.null {
            AppRouter.goToLogin()
        } else {
            AppRouter.goToChatUsersScreen()
        }
    }
}
