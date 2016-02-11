//
//  HomeModel.swift
//  dbtest
//
//  Created by Richard Smith on 08/02/2016.
//  Copyright © 2016 Kinch Systems. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded (items: NSArray)
}

class HomeModel: NSObject, NSURLSessionDataDelegate {
    // properties
    weak var delegate: HomeModelProtocol!
    var data : NSMutableData = NSMutableData()
    var adata : NSArray = NSArray()
    
    let urlPath: String = "http://www.ksys.co.uk/pl01.php"
    // let urlPath: String = "http://jsonplaceholder.typicode.com/posts"
    
    func downloadItems() {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        
        task.resume()
    }
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            
            
            
            
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        // var post : NSDictionary = NSDictionary()
        
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options:NSJSONReadingOptions.AllowFragments) as! NSMutableArray
            
            // post = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
        }
        
            catch let error as NSError {
            print("parse error:")
            print(error)
            
        }
        
        // print ("the post is: " + post.description)
        print ("entries = " + String(jsonResult.count));
        
        var jsonElement: NSDictionary = NSDictionary()
        let locations: NSMutableArray = NSMutableArray()
        
        for(var i = 0; i < jsonResult.count; i++)
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let address1 = jsonElement["Address-1"] as! String
            let address2 = jsonElement["Address-2"] as! String
            let address3 = jsonElement["Address-3"] as! String
            let postcode = jsonElement["Postcode"] as! String
            
            print ("addr1: " + address1)
            
            let location = LocationModel(a1:address1, a2:address2, a3:address3, pcode:postcode )
            
            print(location);
            
            
            locations.addObject(location)
            
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.delegate.itemsDownloaded(locations)
            
        })
    }
    

    
    
}



