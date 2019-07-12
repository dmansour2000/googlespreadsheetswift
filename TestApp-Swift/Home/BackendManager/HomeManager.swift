//
//  HomeManager.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities
import SwiftyJSON

enum AutenticationError: Error {
    case server
    case badReponse
    case badCredentials
}

enum AutenticationStatus {
    case none
    case error(AutenticationError)
    case user(String)
}

typealias JSONDictionary = [String: Any]



class HomeManager {
    
    
    let status = Variable(AutenticationStatus.none)
    static var sharedManager = HomeManager()
    
    fileprivate init() {}
    
    func home() -> Observable<BaseModel>{
        
        let url = NSURL(string: Constants.BASE_URL )!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.json(request: request as URLRequest)
            .map {
                if var model = $0 as? JSONDictionary{
                    
                    
                    let spreadsheetId = model["spreadsheetId"] as! String
                    
                    let valueRanges = model["valueRanges"]  as! [NSDictionary]
                    
                  
                    
                 
                    
                    var rowsModelArray = NSMutableArray.init()
                   
                        let titlerows = RowsModel.init(range: valueRanges[0].object(forKey: "range") as! String , majorDimension: valueRanges[0].object(forKey: "majorDimension") as! String, values: valueRanges[0].object(forKey: "values") as! [[String]])
                        
                        rowsModelArray.add(titlerows)
            
                   
                        let imagesrows = RowsModel.init(range: valueRanges[1].object(forKey: "range") as! String , majorDimension: valueRanges[1].object(forKey: "majorDimension") as! String, values: valueRanges[1].object(forKey: "values") as! [[String]])
                        
                        rowsModelArray.add(imagesrows)
               
                    
                    
                     let rowsArray = rowsModelArray as! NSArray
                    
                      let model = BaseModel.init(spreadsheetId: spreadsheetId, valuesRanges: rowsArray as! [RowsModel])
                   
                    return model
                }else{
                    let model = BaseModel.init(spreadsheetId: "", valuesRanges: [])
                    
                    return model
                }
                
        }
        // .catchErrorJustReturn(.error(.server))
        
        
        
        
    }
    
    
    
    
}

