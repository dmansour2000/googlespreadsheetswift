//
//  UIHelper.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import UIKit
import SwiftMessages

public class UIHelper {
    
    public static func showSuccessMessage(_ message: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.removeFromSuperview()
        view.configureContent(title: HomeUtils.localizedString(forKey: "successTitle"), body: message)
        
        let config = getShowMessageConfig()
        SwiftMessages.show(config: config, view: view)
    }
    
    public static func showErrorMessage(_ message: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.button?.removeFromSuperview()
        view.configureContent(title: HomeUtils.localizedString(forKey: "errorTitle"), body: message)
        let config = getShowMessageConfig()
        SwiftMessages.show(config: config, view: view)
    }
    
    private static func getShowMessageConfig() -> SwiftMessages.Config{
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
       // config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        return config
    }
    
    
}
