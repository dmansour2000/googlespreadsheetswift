//
//  HomeViewModel.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities

struct HomeViewModel {
    
    let activityIndicator = ActivityIndicator()
    
    
    
    func home()-> Observable<BaseModel>  {
        return HomeManager.sharedManager.home()
    }
    
    
}
