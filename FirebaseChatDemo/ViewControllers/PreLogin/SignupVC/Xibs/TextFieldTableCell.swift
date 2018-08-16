//
//  TextFieldTableCell.swift
//  NewProject
//
//  Created by Bhavneet Singh on 27/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class TextFieldTableCell: UITableViewCell {

    @IBOutlet weak var textField: CustomTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
