//
//  ChatUserTableCell.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 13/08/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class ChatUserTableCell: UITableViewCell {
    
    //MARK:- IBOutlets
    //==================
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    
    //MARK:- IBActions
    //==================
    
    
}

//MARK:- Life Cycle
//===================
extension ChatUserTableCell {
    
    /// Awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height/2
    }
}

//MARK:- Private Functions
//===========================
extension ChatUserTableCell {
    
    /// Awake from nib
    private func initialSetup() {
        
        self.profileImageView.image = #imageLiteral(resourceName: "profile")
        let timeLabelWidth = self.timeLabel.intrinsicContentSize.width
        self.timeLabel.widthAnchor.constraint(equalToConstant: timeLabelWidth).isActive = true
    }
}
