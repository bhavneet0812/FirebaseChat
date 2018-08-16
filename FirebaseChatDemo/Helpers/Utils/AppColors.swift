//
//  AppColors.swift
//  DannApp
//
//  Created by Aakash Srivastav on 20/04/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

struct AppColors {
    
    static var theme: UIColor                       { return #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.4588235294, alpha: 1) } // rgb 81 148 117
    static var white: UIColor                       { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) } // rgb 255 255 255
    static var loaderColor: UIColor                 { return #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.4588235294, alpha: 1) } // rgb 81 148 117
    static var loaderBkgroundColor: UIColor         { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.145708476) } // rgb 0 0 0 alpha 0.5
    
    static var textfield_Border: UIColor            { return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) }
    static var textfield_Text: UIColor              { return #colorLiteral(red: 0.1884121193, green: 0.1884121193, blue: 0.1884121193, alpha: 1) }
    static var textfield_Title: UIColor             { return #colorLiteral(red: 0.1884121193, green: 0.1884121193, blue: 0.1884121193, alpha: 1) }
    static var textfield_Error: UIColor             { return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1) }
}
