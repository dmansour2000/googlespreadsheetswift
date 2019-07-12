//
//  TestApp-SwiftUtils.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import UIKit

class StoreManagerUtils {
    
    
    static let VIEW_SCREEN_WIDTH         = UIScreen.main.nativeBounds.width
    static let VIEW_SCREEN_HEIGHT        = UIScreen.main.nativeBounds.height
    static let VIEW_SCREEN_MAX_LENGTH    = max(VIEW_SCREEN_WIDTH, VIEW_SCREEN_HEIGHT)
    
    static func isIPhone4() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 960
    }
    
    static func isIPhone5() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 1136
    }
    static func isIPhone6() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 1334
    }
    static func isIPhone6Plus() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 1920
    }
    static func isIPhoneX() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 2436
    }
    static func isIPhoneXR() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && VIEW_SCREEN_MAX_LENGTH == 1792
    }
}
