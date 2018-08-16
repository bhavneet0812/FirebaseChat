//
//  Constants.swift
//  Onboarding
//
//  Created by Appinventiv on 13/09/17.
//  Copyright © 2017 Gurdeep Singh. All rights reserved.
//

import Foundation

enum Constants {
    
    static let AppTitle = "Firebase Chat"

    
    //MARK:- Validations
    //==================
    static let EnterEmail = "EnterEmail"
    static let InvalidEmail = "InvalidEmail"
    static let InvalidFirstName = "InvalidFirstName"
    static let InvalidMiddleName = "InvalidMiddleName"
    static let InvalidLastName = "InvalidLastName"
    static let FirstNameInvalidLength = "FirstNameInvalidLength"
    static let InvalidUsername = "InvalidUsername"
    static let EnterFirstName = "EnterFirstName"
    static let EnterMiddleName = "EnterMiddleName"
    static let EnterLastName = "EnterLastName"
    static let LastNameInvalidLength = "LastNameInvalidLength"
    
    static let UserNameInvalidLength = "UserNameInvalidLength"
    
    static let InvalidPhone = "InvalidPhone"
    static let InvalidPassword = "InvalidPassword"
    static let MinimumAgeLimit = "MinimumAgeLimit"
    static let MaximumAgeLimit = "MaximumAgeLimit"
    static let EnterMobile = "EnterMobile"
    static let EnterPassword = "EnterPassword"
    static let EnterConfirmPassword = "EnterConfirmPassword"
    static let ConfirmPasswordWrong = "ConfirmPasswordWrong"
    static let InvalidCityName = "InvalidCityName"
    static let CityNameInvalidLength = "CityNameInvalidLength"
    static let EnterCityName = "EnterCityName"
    
    static let InvalidRegionName = "InvalidRegionName"
    static let RegionNameInvalidLength = "RegionNameInvalidLength"
    static let EnterRegionName = "EnterRegionName"
    
    static let InvalidCountryCode = "InvalidCountryCode"
    static let EnterCountryCode = "EnterCountryCode"
    
    static let BiographyInvalidLength = "BiographyInvalidLength"
    static let EnterBiography = "EnterBiography"
    
    static let SomethingWentWrong = "SomethingWentWrong"
    
    //MARK:- SignupVC
    //===============
    static let Male = "Male"
    static let Female = "Female"
    static let Other = "Other"
    
    static let Name = "Name"
    static let FirstName = "FirstName"
    static let MiddleName = "MiddleName"
    static let LastName = "LastName"
    static let UserName = "UserName"
    static let Gender = "Gender"
    static let DateOfBirth = "DateOfBirth"
    static let PhoneNo = "PhoneNo"
    static let City = "City"
    static let CountryCode = "CountryCode"
    static let Region = "Region"
    static let Longitude = "Longitude"
    static let Latitude = "Latitude"
    static let PostalCode = "PostalCode"
    static let ConfirmPassword = "ConfirmPassword"
    static let Done = "Done"
    
    
    //MARK:- LoginVC
    //==============
    static let Ok = "Ok"
    static let Login = "Login"
    static let Back = "Back"
    static let EmailAddress = "EmailAddress"
    static let Password = "Password"
    static let ForgotPassword = "ForgotPassword"
    static let Logout = "Logout"
    
    //MARK:- ForgotPasswordVC
    //=======================
    static let SendOTPToEmailAddress = "SendOTPToEmailAddress"
    static let Continue = "Continue"
    
    //MARK:- UserDetailViewController
    //===============================
    static let ChangePassword = "ChangePassword"
    
    //MARK:- HomeViewController
    //=========================
    static let SignUp = "SignUp"
    
    
    //MARK:- ChangePasswordVC
    //=======================
    static let OldPassword = "OldPassword"
    static let NewPassword = "NewPassword"
    static let EnterOldPassword = "EnterOldPassword"
    static let InvalidOldPassword = "InvalidOldPassword"
    static let EnterNewPassword = "EnterNewPassword"
    static let InvalidNewPassword = "InvalidNewPassword"
    
    
    //MARK:- CountryCodeVC
    //=======================
    static let SelectCountry = "SelectCountry"
    static let SearchCountry = "SearchCountry"
    
    //MARK:- ResetPasswordVC
    //======================
    static let EnterNewPasswordForYourAccount = "EnterNewPasswordForYourAccount"
    
    
    //MARK:- UIViewController Extension
    //=================================
    static let ChooseOptions = "ChooseOptions"
    static let Camera = "Camera"
    static let CameraNotAvailable = "CameraNotAvailable"
    static let ChooseFromGallery = "ChooseFromGallery"
    static let TakePhoto = "TakePhoto"
    static let Cancel = "Cancel"
    static let Alert = "Alert"
    
    static let Settings = "Settings"
    static let RestrictedFromUsingCamera = "RestrictedFromUsingCamera"
    
    static let ChangePrivacySettingAndAllowAccessToCamera = "ChangePrivacySettingAndAllowAccessToCamera"
    static let RestrictedFromUsingLibrary = "RestrictedFromUsingLibrary"
    static let ChangePrivacySettingAndAllowAccessToLibrary = "ChangePrivacySettingAndAllowAccessToLibrary"

    // MARK :- RANDOM KEYWORDS
    //========================
    static var Success: String                                              { return "Success" }
    static var Error: String                                                { return "Error" }
    static var RestrictedCameraDeviceWithoutCameraAccessWork: String        { return "RestrictedCameraDeviceWithoutCameraAccessWork" }
    static var RestrictedLibraryWithoutCameraAccessWork: String             { return "RestrictedLibraryWithoutCameraAccessWork" }
    static var ChangePrivacyFromSettingsAndAllowAccessCamera: String        { return "ChangePrivacyFromSettingsAndAllowAccessCamera" }
    static var ChangePrivacyFromSettingsAndAllowAccessLibrary: String       { return "ChangePrivacyFromSettingsAndAllowAccessLibrary" }
    static var NoInternetConnection: String                                 { return "NoInternetConnection"}
}
