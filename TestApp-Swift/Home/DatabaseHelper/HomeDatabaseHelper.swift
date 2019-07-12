//
//  HomeDatabaseHelper.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/6/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import UIKit


class HomeDatabaseHelper: NSObject {
    
    public func getImages() -> ImageModel{
        
        let userDefaults = UserDefaults.standard
        var className = ImageModel.init(images:[""])
        let dataretrieved = userDefaults.object(forKey: "images") as! NSData
        className = NSKeyedUnarchiver.unarchiveObject(with: dataretrieved as Data) as! ImageModel
        return className
        
    }
    
    
    public func saveImages(images : ImageModel){
        
        let userDefaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject:images) as NSData
        userDefaults.set(data, forKey: "images" )
        userDefaults.synchronize()
        
        
        
    }
}

