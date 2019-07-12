//
//  NetworkHelper.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Method : String
{
    case get="GET"
    case post="POST"
    
}


enum ResponseType : Int{
    case StringJson = 0
    case DictionaryJson = 1
    
}


class NetworkHelper
{
    //Core Function of network
    internal static func networkRequester(
        domainUrl:String?,
        service:String,
        contentType:String?,
        hTTPMethod: Method,
        parameters: [String:Any]? = nil,
        httpBody:String? = nil,
        httpBodyData:Data? = nil,
        responseType: ResponseType = .StringJson,
        callbackNoInterent: (() -> Void)? = nil,
        callbackString: ((DataResponse<String>) -> Void)? = nil,
        callbackSwiftyDic: ((_ JSON: JSON, _ Error: Error?) -> Void)? = nil)
    {
        
        //mariam
        
        let UrlString = domainUrl! + service;
        var request = URLRequest(url: URL(string: UrlString)!)
        
        
        if Utilities.shared.isConnectedToNetwork() == true {
            
            request.httpMethod = hTTPMethod.rawValue
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            
            // Fill httpBody Data
            if (hTTPMethod == .post){
                
                if(httpBodyData != nil){
                    
                    request.httpBody = httpBodyData
                }
                else{
                    
                    var formdata = ""
                    var HttpBodyString = httpBody == nil ? "" : httpBody!
                    
                    if let params = parameters{
                        
                        for param in params{
                            
                            formdata += "\(param.0)=\(param.1)&"
                        }
                        
                        formdata = String(formdata.characters.dropLast())
                        HttpBodyString = formdata
                    }
                    
                    request.httpBody = HttpBodyString.data(using: String.Encoding.utf8)
                    
                }
            }
            
            if (contentType != nil){
                let headers: HTTPHeaders = [
                    "Content-Type": contentType!
                ]
                
                for header in headers {
                    request.setValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            
            print("✍🏻 Request URL >>>> " + UrlString)
            print("✍🏻 Request Body >>>> " + (httpBody == nil ? (parameters == nil ? "" : String(describing: parameters!)) : httpBody!))
            
            Alamofire.request(request)
                .responseString { response in
                    
                    switch response.result {
                        
                    case .failure(let error):
                        print("❌ Respons Error >>>> " + error.localizedDescription)
                        
                        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                            print("❌ Respons Error Details >>>> " + responseString)
                            
                            if (responseType == .StringJson){
                                
                                callbackString!(response)
                            }
                            else if (responseType == .DictionaryJson){
                                
                                //   callbackSwiftyDic!(JSON.null, response.result.error)
                            }
                        }
                        
                        
                    case .success(let responseObject):
                        print("✅ Respons Object >>>> " + responseObject)
                        
                        if (responseType == .StringJson){
                            
                            callbackString!(response)
                        }
                        else{
                            
                            //    callbackSwiftyDic!(JSON.parse(response.result.value!), response.result.error)
                        }
                        
                    }
                    
            }
            
        }// check Internet Conection
            
        else{
            print("⁉️ No Internet Conection!")
            callbackNoInterent!()
        }
        
    }
    
    
}
