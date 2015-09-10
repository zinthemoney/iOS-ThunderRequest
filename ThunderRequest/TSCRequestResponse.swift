//
//  TSCRequestResponse.swift
//  ThunderRequest
//
//  Created by Matthew Cheetham on 09/09/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit
import Foundation

/**
A more useful representation of a NSURLResponse object. This object contains useful properties to help access response data from a data request quickly
*/
public class TSCRequestResponse: NSObject {
    
    /**
    @abstract Raw NSData returned from the server
    */
    public var data: NSData?
    
    /**
    @abstract The NSHTTPURLResponse object returned from the request. Contains information such as HTTP response code
    */
    public var HTTPresponse: NSHTTPURLResponse?
    
    /**
    @abstract A HTTP response code
    */
    public var status: Int {
        
        get {
        
            return HTTPresponse?.statusCode ?? -1
        
        }
        
    }
    
    /**
    @abstract An object representation of the response data. Parsed from JSON.
    */
    public var object: AnyObject? {
        
        get {
            
            do {
                
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                return jsonObject
                
            } catch let error as NSError {
                
                print(error)
                return nil
                
            }
            
        }
        
    }
    
    /**
    @abstract An array representation of the response data
    */
    public var array: Array<AnyObject>? {
        
        get {
            
            if let arrayObject = object as? Array<AnyObject>? {
                
                return arrayObject
                
            }
            
            return nil
            
        }
        
    }
    
    /**
    @abstract An dictionary representation of the response data
    */
    public var dictionary: Dictionary<String, AnyObject>? {
        
        get {
            
            if let dictionaryObject = object as? Dictionary<String, AnyObject>? {
                
                return dictionaryObject
                
            }
            
            return nil
            
        }
        
    }
    
    /**
    @abstract An string representation of the response data
    */
    public var string: String? {
        
        get {
            
            if let stringObject = NSString(data:data!, encoding:NSUTF8StringEncoding) as? String {
                
                return stringObject
                
            }
            
            return nil
            
        }
        
    }
    
    /**
    @abstract A dictionary representation of the headers the server responded with
    */
    public var responseHeaders: Dictionary<NSObject, AnyObject>? {
        
        
        get {
            
            if let httpResponseHeaders = HTTPresponse?.allHeaderFields {
                
                return httpResponseHeaders
                
            }
            
            return nil
            
        }
        
    }
   
    /**
    Initialises a new response object using the response given by NSURLSession
    */
    public init(response: NSURLResponse?, data: NSData?) {
        
        self.data = data
        HTTPresponse = response as? NSHTTPURLResponse
        
    }
    
}
