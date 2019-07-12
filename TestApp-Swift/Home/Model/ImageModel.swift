//
//  ImageModel.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import UIKit

class ImageModel: NSObject , NSCoding{
    
    var images: [String]
    
    init(images:[String]) {
        self.images = images
        
    }
    
    // MARK: NSCoding
    public convenience required init?(coder aDecoder: NSCoder) {
        
        let images = aDecoder.decodeObject(forKey: "imagess") as! [String]
        
        
        self.init(images:images)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(images, forKey: "imagess")
        
    }
    
}

