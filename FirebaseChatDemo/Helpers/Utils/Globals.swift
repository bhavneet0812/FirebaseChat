//
//  Globals.swift
//  Onboarding
//
//  Created by Appinventiv on 22/08/16.
//  Copyright © 2016 Gurdeep Singh. All rights reserved.
//

import Foundation
import UIKit

func printDebug<T>(_ obj : T) {
    #if DEBUG
        print(obj)
    #endif
}

var isSimulatorDevice:Bool {

    var isSimulator = false
    #if arch(i386) || arch(x86_64)
        //simulator
        isSimulator = true
    #endif
    return isSimulator
}

// MARK:- DATE FORMAT ENUM
//==========================
enum DateFormat : String {
    
    case yyyy_MM_dd = "yyyy-MM-dd"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddTHHmmssz = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yyyyMMddTHHmmssssZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.ssZZZZZ"
    case yyyyMMdd = "yyyy/MM/dd"
    case dMMMyyyy = "d MMM, yyyy"
    case ddMMMyyyy = "dd MMM, yyyy"
    case MMMdyyyy = "MMM d, yyyy"
    case hmmazzz = "h:mm a zzz"
}

func isDeviceIsIphoneX() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return false
        case 1334:
            return false
        case 2208:
            return false
        case 2436:
            return true
        default:
            return false
        }
    }
    return false
}


