//
//  AllUsersVC.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 15/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class AllUsersVC: BaseVC {
    
    // MARK:- Variables
    // ==================
    let controller = AllUsersController()
    var users: [UserModel] = []
    
    // MARK:- IBOutlets
    // ==================
    @IBOutlet weak var mainTableView: UITableView!
    
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller.getUsers(allUsers: &users)
        self.initialSetup()
    }
    
    // MARK:- IBActions
    // ==================

}

// MARK:- Table View Delegate and DataSource
// =============================================
extension AllUsersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(with: ChatUserTableCell.self)
        
        let indexUser = self.users[indexPath.row]
        
        cell.profileImageView.setImage_kf(imageString: indexUser.profilePic ?? "", placeHolderImage: #imageLiteral(resourceName: "profile"))
        cell.lastMessageLabel.text = indexUser.status
        cell.profileNameLabel.text = indexUser.name
        cell.timeLabel.isHidden = true
        cell.unreadCountLabel.isHidden = true
        cell.lastMessageLabel.isHidden = indexUser.status.isEmpty

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}


// MARK:- Functions
// ===================
extension AllUsersVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.registerCell(with: ChatUserTableCell.self)
    }
}
