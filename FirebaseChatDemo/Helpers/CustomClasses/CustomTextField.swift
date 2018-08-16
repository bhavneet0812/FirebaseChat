//
//  CTextField.swift
//  DittoFashionMarketBeta
//
//  Created by Bhavneet Singh on 29/11/17.
//  Copyright © 2017 Bhavneet Singh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

// MARK:- CUSTOM TEXT FIELD
//=================================
class CustomTextField: MarginTextField, UITextFieldDelegate {
    
    // MARK:- Variables
    //===================
    let underline = UIView()
    var errorLabel = UILabel()
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    var isSecured: Bool = true {
        didSet{
            self.isSecureTextEntry = !self.isSecureTextEntry
        }
    }
    
    private var pickerData: [String] = []
    
    // MARK:- Initializers
    //======================
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
        self.setupKeyboard()
        self.setupBottomBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubviews()
        self.setupKeyboard()
        self.setupErrorLabel()
        self.setupBottomBorder()
    }
    
    // MARK:- Layout Subviews
    //=========================
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupFrames()
        self.setupErrorLabelFrames()
    }
}

// MARK:- Private Setup Functions
//================================
extension CustomTextField {
    
    /// Setup Subviews
    private func setupSubviews() {
        
        self.clipsToBounds = false
        self.borderStyle = .none
        
        self.font = AppFonts.Montserrat_Medium.withSize(15.0)
        self.textColor = AppColors.textfield_Text
        
        self.rightViewMode = .never
        self.rightView = nil
        self.inputView = nil

        if let rootVC = AppDelegate.shared.window?.rootViewController {
            returnKeyHandler = IQKeyboardReturnKeyHandler(controller: rootVC)
            returnKeyHandler?.lastTextFieldReturnKeyType = .done
            returnKeyHandler?.addTextFieldView(self)
        }
    }
    
    /// Setup Error Label
    private func setupErrorLabel() {
        
        self.errorLabel.font = AppFonts.Montserrat_Medium.withSize(12)
        self.errorLabel.textColor = AppColors.white
        self.errorLabel.textAlignment = .left
        self.addSubview(self.errorLabel)
    }
    
    /// Setup Error Label Frames
    private func setupErrorLabelFrames() {
        
        self.errorLabel.frame = CGRect(x: 0, y: self.frame.height,
                                       width: self.frame.width, height: self.frame.height/2)
    }
    
    /// Setup Keyboard
    private func setupKeyboard() {
        
        self.autocapitalizationType = .sentences
        self.autocorrectionType = .no
        self.keyboardType = .asciiCapable
        self.keyboardAppearance = .default
    }
    
    /// Setup Frames
    private func setupFrames(){
        
        self.rightView?.frame.size = CGSize(width: rightView!.intrinsicContentSize.width+10, height: bounds.height)
        underline.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1)
    }
    
    /// Setup Bottom Border
    private func setupBottomBorder() {
        
        let height = CGFloat(0.25)
        underline.backgroundColor = UIColor.clear
        underline.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        self.addSubview(underline)
        self.clipsToBounds = false
        
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 0.5
        self.layer.borderColor = AppColors.textfield_Border.cgColor
        
    }
    
    /// Show Button Tapped
    @objc private func showButtonTapped(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        self.isSecured = !self.isSecured
    }
}


// MARK:- Setup Functions
//==========================
extension CustomTextField {
    
    /// Name TextField
    func setupNameTextField() {
        
        self.keyboardType = .asciiCapable
        self.autocapitalizationType = .words
        self.placeholder = Constants.Name.localized
    }

    /// First Name TextField
    func setupFirstNameTextField() {
        
        self.keyboardType = .asciiCapable
        self.autocapitalizationType = .words
        self.placeholder = Constants.FirstName.localized
    }
    
    /// Middle Name TextField
    func setupMiddleNameTextField() {
        
        self.setupFirstNameTextField()
        self.placeholder = Constants.MiddleName.localized
    }
    
    /// Last Name TextField
    func setupLastNameTextField() {
        
        self.setupFirstNameTextField()
        self.placeholder = Constants.LastName.localized
    }
    
    /// User Name TextField
    func setupUserNameTextField() {
        
        self.keyboardType = .asciiCapable
        self.autocapitalizationType = .none
        self.placeholder = Constants.UserName.localized
    }

    /// Email TextField
    func setupEmailTextField() {
        
        self.keyboardType = .emailAddress
        self.autocapitalizationType = .none
        self.placeholder = Constants.EmailAddress.localized
    }
    
    /// Gender TextField
    func setupGenderTextField() {

        self.keyboardType = .asciiCapable
        self.autocapitalizationType = .none
        self.isSecureText = false
        self.rightViewMode = .never
        self.rightView = nil
        self.inputView = nil
        self.placeholder = Constants.Gender.localized
    }
    
    /// DOB TextField
    func setupDOBTextField(start: Date? = nil, end: Date? = nil, current: Date = Date(), didSelectDate: @escaping ((Date) -> Void)) {
        
        self.placeholder = Constants.DateOfBirth.localized
        self.createDatePicker(start: start, end: end, current: current, didSelectDate: didSelectDate)
    }
    
    /// Phone Number TextField
    func setupPhoneNumberTextField() {
        
        self.keyboardType = .numberPad
        self.autocapitalizationType = .none
        self.placeholder = Constants.PhoneNo.localized
    }

    ///Passowrd Textfield
    func setupPasswordTextField() {
        
        self.placeholder = Constants.Password.localized

        self.keyboardType = .asciiCapable
        self.isSecureTextEntry = isSecured
        self.rightViewMode = .always
        self.inputView = nil

        let showButton = UIButton()
        showButton.setTitle("Show", for: .normal)
        showButton.setTitle("Hide  ", for: .selected)
        showButton.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(15)
        showButton.setTitleColor(AppColors.textfield_Text, for: .normal)
        showButton.setTitleColor(AppColors.textfield_Text, for: .selected)
        
        showButton.addTarget(self, action: #selector(self.showButtonTapped(_:)), for: .touchUpInside)
        self.setButtonToRightView(btn: showButton, selectedImage: nil, normalImage: nil, size: nil)
    }
    
    /// Old Password TextField
    func setupOldPasswordTextField() {
        
        self.setupPasswordTextField()
        self.placeholder = Constants.OldPassword.localized
    }

    /// New Password TextField
    func setupNewPasswordTextField() {
        
        self.setupPasswordTextField()
        self.placeholder = Constants.NewPassword.localized
    }
    
    /// Confirm Password TextField
    func setupConfirmPasswordTextField() {
        
        self.setupPasswordTextField()
        self.placeholder = Constants.ConfirmPassword.localized
    }

    /// City TextField
    func setupCityTextField() {
        
        self.setupFirstNameTextField()
        self.placeholder = Constants.City.localized
    }

    /// Country Code TextField
    func setupCountryCodeTextField() {
        
        self.keyboardType = .numberPad
        self.autocapitalizationType = .none
        self.placeholder = Constants.CountryCode.localized
    }

    /// Region TextField
    func setupRegionTextField() {
        
        self.setupFirstNameTextField()
        self.placeholder = Constants.Region.localized
    }

    /// Longitude TextField
    func setupLongitudeTextField() {
        
        self.keyboardType = .numberPad
        self.autocapitalizationType = .none
        self.placeholder = Constants.Longitude.localized
    }

    /// Latitude TextField
    func setupLatitudeTextField() {
        
        self.keyboardType = .numberPad
        self.autocapitalizationType = .none
        self.placeholder = Constants.Latitude.localized
    }

    /// Postal Code TextField
    func setupPostalCodeTextField() {
        
        self.keyboardType = .numberPad
        self.autocapitalizationType = .none
        self.placeholder = Constants.PostalCode.localized
    }

    /// CREATE PICKER
    //================
    func createPicker(stringsArray: [String], didSelectDate: @escaping ((String) -> Void)) {
        
        guard inputView == nil else { return }
        
        self.pickerData = stringsArray
        
        var picker = UIPickerView()
        
        /// Picker
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIDevice.width, height: 216))
        picker.backgroundColor = UIColor.white
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        self.inputView = picker

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain) { (_) in
            
            self.text = stringsArray[picker.selectedRow(inComponent: 0)]
            self.resignFirstResponder()
            
            didSelectDate(stringsArray[picker.selectedRow(inComponent: 0)])
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain) { (_) in
            self.resignFirstResponder()
        }
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
    }
}


// MARK:- Picker View Delegate and Datasource
//==============================================
extension CustomTextField: UIPickerViewDelegate, UIPickerViewDataSource {

    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
}
