//
//  CustomButton.swift
//  Onboarding
//
//  Created by Bhavneet Singh on 06/07/18.
//  Copyright © 2018 Gurdeep Singh. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    // MARK: Enums
    //==============
    enum CustomButtonType {
        case themeColor, whiteColor
    }
    
    // MARK: Variables
    //===================
    var btnType = CustomButtonType.themeColor {
        didSet{
            self.setupSubviews()
        }
    }
    
    // MARK: Initializers
    //=====================
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubviews()
    }
    
    // MARK: Life Cycle Functions
    //==============================
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupLayouts()
    }
}

// MARK: Private Functions
//==========================
extension CustomButton {
    
    /// Setup Subviews
    private func setupSubviews() {
        
        switch btnType {
        case .themeColor:
            self.backgroundColor = AppColors.theme
            self.setTitleColor(AppColors.white, for: .normal)
            self.layer.borderColor = AppColors.white.cgColor
        case .whiteColor:
            self.backgroundColor = AppColors.white
            self.setTitleColor(AppColors.theme, for: .normal)
            self.layer.borderColor = AppColors.theme.cgColor
        }
        
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        
        self.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(16)
    }
    
    /// Setup Layouts
    private func setupLayouts() {
        
        self.layer.cornerRadius = self.frame.height/2
    }
}

// MARK: Functions
//===================
extension CustomButton {
    

}
