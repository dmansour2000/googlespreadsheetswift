//
//  HomeUtils.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
import Kingfisher

public class HomeUtils {
    
    public static func scalePt(pt: CGFloat) -> CGFloat {
        return pt;
    }
    
    
    public static func isIPhone() -> Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    public static func isIPad() -> Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    
    public static func localizedString(forKey key: String) -> String {
        Localize.setCurrentLanguage("en")
        let resutl = key.localized(using: "Main", in: .main)
        return resutl;
    }
    

    
}
