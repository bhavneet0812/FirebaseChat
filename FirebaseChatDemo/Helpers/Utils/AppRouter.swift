//
//  Router.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 29/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

enum AppRouter {
    
    static func goToChatUsersScreen() {
        
        let mainViewController = ChatUsersVC.instantiate(fromAppStoryboard: .Chat)
        
        AppDelegate.shared.nvc = UINavigationController(rootViewController: mainViewController)
        AppDelegate.shared.nvc?.isNavigationBarHidden = false
        
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController =  AppDelegate.shared.nvc
        }, completion: { (finished) in
            UIApplication.shared.registerForRemoteNotifications()
        })
        
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    static func goToLogin() {
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        AppUserDefaults.removeAllValues()
        
        let getStartedScene = LoginVC.instantiate(fromAppStoryboard: .PreLogin)
        
        AppDelegate.shared.nvc = UINavigationController(rootViewController: getStartedScene)
        AppDelegate.shared.nvc?.isNavigationBarHidden = false
        AppDelegate.shared.nvc?.automaticallyAdjustsScrollViewInsets = false
        
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController = AppDelegate.shared.nvc
        }, completion: nil)
        
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    static func goToVC(viewController: UIViewController) {
        
        AppDelegate.shared.nvc = UINavigationController(rootViewController: viewController)
        
        AppDelegate.shared.nvc?.isNavigationBarHidden = true
        AppDelegate.shared.nvc?.automaticallyAdjustsScrollViewInsets = false
        UIView.transition(with: AppDelegate.shared.window!, duration: 0.33, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            AppDelegate.shared.window?.rootViewController = AppDelegate.shared.nvc
        }, completion: nil)
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
}
