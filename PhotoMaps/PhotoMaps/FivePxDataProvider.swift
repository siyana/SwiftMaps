//
//  FivePxDataProvider.swift
//  PhotoMaps
//
//  Created by Siyana Slavova on 4/9/15.
//  Copyright (c) 2015 Siyana Slavova. All rights reserved.
//

import Foundation

class FivePxDataProvider: NSObject {
    
    var photoTask = NSURLSessionDataTask()
    var session: NSURLSession {
        return NSURLSession.sharedSession()
    }
    
    func fetchPhotos(photoTag: String, completion: (([String]) -> Void)) -> ()  {
        let urlString = "https://api.500px.com/v1/photos?feature=fresh_today&sort=created_at&image_size=3&include_store=store_download&include_states=voted&tags="+photoTag+"&consumer_key=" + GlobalConstants.fivePxApiKey
        
        if photoTask.taskIdentifier > 0 && photoTask.state == .Running {
            photoTask.cancel()
        }
        
        if let url = NSURL(string: urlString){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            photoTask = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(self.parseResponseData(data))
            })
            
            photoTask.resume()
        }
    }
    
    private func parseResponseData(data: NSData) -> ([String]){
        var imagesUrlArray = [String]()
        
        if let json = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as? NSDictionary {
            if let photoArray = json["photos"] as? NSMutableArray {
                for photo:AnyObject in photoArray {
                    if let photoDict = photo as? NSDictionary {
                        if let photoUrl = photoDict["image_url"] as? String {
                            if !photoUrl.isEmpty {
                                imagesUrlArray.append(photoUrl)
                            }
                        }
                    }
                }
            }
        }
        return imagesUrlArray
    }
}
