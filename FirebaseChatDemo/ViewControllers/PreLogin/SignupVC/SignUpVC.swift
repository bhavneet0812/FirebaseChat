//
//  SignUpVC.swift
//  FirebaseChatDemo
//
//  Created by Bhavneet Singh on 29/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC {
    
    // MARK:- Variables
    // ==================
    var numberOfCells = 7
    var user = UserModel()
    var password = ""
    var profilePic: UIImage?
    var controller = SignUpController()

    // MARK:- IBOutlets
    // ==================
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var profileImageBackView: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var addProfilePicBtn: UIButton!
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupFrames()
    }
}

// MARK:- Table View Delegate And DataSource
// ============================================
extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case self.numberOfCells-1:
            
            let cell = tableView.dequeueCell(with: SubmitButtonTableCell.self, indexPath: indexPath)
            
            cell.submitBtn.setTitle(Constants.SignUp.localized, for: .normal)
            cell.submitBtn.addTarget(self, action: #selector(self.submitBtnAction(_:)), for: .touchUpInside)
            
            return cell
            
        default:
            
            let cell = tableView.dequeueCell(with: TextFieldTableCell.self, indexPath: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textField.setupNameTextField()
                cell.textField.text = self.user.name
            case 1:
                cell.textField.setupUserNameTextField()
                cell.textField.text = self.user.username
            case 2:
                cell.textField.setupEmailTextField()
                cell.textField.text = self.user.email
            case 3:
                cell.textField.setupPhoneNumberTextField()
                cell.textField.text = self.user.phoneNumber
            case 4:
                cell.textField.setupPasswordTextField()
                cell.textField.text = self.password
            case 5:
                cell.textField.setupGenderTextField()
                cell.textField.text = self.user.gender
                
                cell.textField.createPicker(stringsArray: ["Male", "Female", "Other"]) { (selectedGender) in
                    self.user.gender = selectedGender
                }
            default: break
            }
            
            cell.textField.addTarget(self, action: #selector(self.textFieldEditingAction(_:)), for: .editingChanged)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64
    }
}

//MARK:- Image Picker Delegate
//===============================
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            self.profilePicImageView.contentMode = .scaleAspectFill
            self.profilePicImageView.image = imagePicked
            self.profilePic = imagePicked
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}


//MARK:- Controller Delegate
//==============================
extension SignUpVC: SignUpControllerProtocol {
    
    func signupSuccess(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
        
        let path = CRootNode.users.rawValue.stringByAppendingPathComponent(path: UserModel.main.userId)
        let userData = UserModel.main.saveToUserDefaults()
        
        FireData.shared.addChild(path: path, data: userData, success: {
            
            AppRouter.goToChatUsersScreen()
            
        }) { (error) in
            
            CommonFunctions.showToastWithMessage(msg: error.localizedDescription, completion: nil)
        }
    }
    
    func signupFailure(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
    }
    
    func validationFailure(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
    }
}

// MARK:- Private Button Actions
// ===============================
extension SignUpVC {
    
    /// Submit Button Action
    @objc private func submitBtnAction(_ btn: CustomButton) {
        
        self.controller.signup(user: self.user, password: self.password, profilePic: self.profilePic)
    }
    
    /// Add Profile Pic Button Action
    @objc private func addProfilePicBtnAction(_ btn: UIButton) {
        self.view.endEditing(true)
        
        self.captureImage(delegate: self)
    }
    
    /// Text Field Editing Action
    @objc private func textFieldEditingAction(_ textField: CustomTextField) {
        
        guard let indexPath = textField.tableViewIndexPath(self.mainTableView) else { return }
        guard let text = textField.text else { return }
        
        switch indexPath.row {
        case 0: self.user.name = text
        case 1: self.user.username = text
        case 2: self.user.email = text
        case 3: self.user.phoneNumber = text
        case 4: self.password = text
        case 5: self.user.gender = text
        default: break
        }
    }
}

// MARK:- Functions
// ===================
extension SignUpVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        self.controller.delegate = self
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.registerCell(with: TextFieldTableCell.self)
        self.mainTableView.registerCell(with: SubmitButtonTableCell.self)

        self.addProfilePicBtn.addTarget(self, action: #selector(self.addProfilePicBtnAction(_:)), for: .touchUpInside)
        
    }
    
    /// Setup Frames
    private func setupFrames() {
        
        self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.frame.height/2
        self.profilePicImageView.layer.borderColor = AppColors.theme.cgColor
        self.profilePicImageView.layer.borderWidth = 0.5
    }
}
