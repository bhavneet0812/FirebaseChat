//
//  BaseVC.swift
//  NewProject
//
//  Created by Bhavneet Singh on 23/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    // MARK:- Variables
    // ==================
    private var isStatusBarWhite = false

    
    // MARK:- IBOutlets
    // ==================
    
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        
        self.makeStatusBarBlack()
    }
}

// MARK:- Functions
// ===================
extension BaseVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        if let nvc = self.navigationController {
            AppDelegate.shared.nvc = nvc
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    /// Make Status Bar White
    func makeStatusBarWhite() {
        self.isStatusBarWhite = true
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    /// Make Status Bar Black
    func makeStatusBarBlack() {
        self.isStatusBarWhite = false
        UIApplication.shared.statusBarStyle = .default
        setNeedsStatusBarAppearanceUpdate()
    }
}
