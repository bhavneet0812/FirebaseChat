//
//  LoginVC.swift
//  NewProject
//
//  Created by Bhavneet Singh on 23/07/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    
    // MARK:- Variables
    // ==================
    var controller = LoginController()
    
    // MARK:- IBOutlets
    // ==================
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var loginBtn: CustomButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var newUserLabel: UILabel!
    
    // MARK:- Life Cycle
    // ===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
}

// MARK:- Controller Delegate Methods
// ====================================
extension LoginVC: LoginControllerProtocol {
    
    func loginSuccess(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
        
        AppRouter.goToChatUsersScreen()
    }
    
    func loginFailure(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
    }
    
    func validationFailure(_ msg: String) {
        CommonFunctions.showToastWithMessage(msg: msg, completion: nil)
    }
}

// MARK:- Private Button Actions
// ===============================
extension LoginVC {
    
    /// Login Button Action
    @objc private func loginBtnAction(_ btn: CustomButton) {
        
        self.controller.login(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
    }

    /// Forgot Button Action
    @objc private func forgotBtnAction(_ btn: UIButton) {
        
        
    }

    /// SignUp Button Action
    @objc private func signupBtnAction(_ btn: UIButton) {
        
        let signupScene = SignUpVC.instantiate(fromAppStoryboard: .PreLogin)
        self.navigationController?.pushViewController(signupScene, animated: true)
    }
}

// MARK:- Private Functions
// ============================
extension LoginVC {
    
    /// Initial Setup
    private func initialSetup() {
        
        self.controller.delegate = self
        
        self.emailTextField.setupEmailTextField()
        self.passwordTextField.setupPasswordTextField()
        
        self.loginBtn.addTarget(self, action: #selector(self.loginBtnAction(_:)), for: .touchUpInside)
        self.forgotPassword.addTarget(self, action: #selector(self.forgotBtnAction(_:)), for: .touchUpInside)
        self.signupBtn.addTarget(self, action: #selector(self.signupBtnAction(_:)), for: .touchUpInside)
    }
}
