//
//  ChatUsersVC.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 10/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class ChatUsersVC: BaseVC {
    
    // MARK:- Variables
    // ==================
    var users: [UserModel] = []
    
    // MARK:- IBOutlets
    // ==================
    @IBOutlet weak var mainTableView: UITableView!
    
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
    
    // MARK:- IBActions
    // ==================
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        let allUsersScene = AllUsersVC.instantiate(fromAppStoryboard: .Chat)
        self.navigationController?.pushViewController(allUsersScene, animated: true)
    }
    
    @IBAction func logoutButtonAction(_ sender: UIBarButtonItem) {
        
        FireAuth.shared.logoutUser(success: {
            AppRouter.goToLogin()
        }) { (error) in
            CommonFunctions.showToastWithMessage(msg: error.localizedDescription, completion: {
                AppRouter.goToLogin()
            })
        }
    
    }
}

// MARK:- Table View Delegate and DataSource
// =============================================
extension ChatUsersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(with: ChatUserTableCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}


// MARK:- Functions
// ===================
extension ChatUsersVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.registerCell(with: ChatUserTableCell.self)
    }
        
}
