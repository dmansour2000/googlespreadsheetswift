//
//  BaseViewController.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import Foundation
import UIKit
import Reachability

class BaseViewController: UIViewController {
    var dialogFullScreenView: UIView?
    var dialogLoadingGroup: STLoadingGroup?
    override func viewDidLoad() {
        super.viewDidLoad()

       
      
    }
    

    public func showProgressDialog(){
        dialogLoadingGroup = STLoadingGroup(side: 80, style: .arch)
        
        if dialogFullScreenView == nil {
            dialogFullScreenView = UIView(frame: self.view.frame)
            dialogFullScreenView?.backgroundColor = UIColor.darkGray
        }
        
        if !(dialogFullScreenView?.isDescendant(of: self.view))!{
            self.view.addSubview(dialogFullScreenView!)
            //dialogFullScreenView?.fillScreenLayoutConstrains()
        }
        
        dialogLoadingGroup?.show(dialogFullScreenView)
        dialogLoadingGroup?.startLoading()
    }
    
    public func hideProgressDialog(){
        dialogLoadingGroup?.stopLoading()
        dialogFullScreenView?.removeFromSuperview()
    }
    
    public func showErrorMessage(_ message: String){
        UIHelper.showErrorMessage(message)
    }
    
    public func isNetworkConnected() -> Bool{
        let reachability = Reachability()!
        return reachability.isReachable
    }
    
    public func showNoNetworkConnectedMessage(){
        UIHelper.showErrorMessage(HomeUtils.localizedString(forKey: "noNetworkConnected"))
    }
    


}
