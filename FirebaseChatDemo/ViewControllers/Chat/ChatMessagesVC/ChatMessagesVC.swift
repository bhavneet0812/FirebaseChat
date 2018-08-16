//
//  ChatMessagesVC.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 13/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class ChatMessagesVC: BaseVC {
    
    // MARK:- Variables
    // ==================
    
    
    // MARK:- IBOutlets
    // ==================
    @IBOutlet weak var mainTableView: UITableView!
    
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
}

// MARK:- Functions
// ===================
extension ChatMessagesVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        
    }
}
